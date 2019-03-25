//
//  CollectionDetailVC.swift
//  Collections
//
//  Created by Matthew Gill on 3/21/19.
//  Copyright © 2019 Matthew Gill. All rights reserved.
//

import UIKit

class CollectionDetailVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    @IBOutlet weak var tableView: UITableView!
    var customCollection: CustomCollection
    var productsArr = [Product]()
    var collectionName = String()
    
    init(collection: CustomCollection) {
        self.customCollection = collection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionName = customCollection.title.replacingOccurrences(of: " collection", with: "")
        titleLabel.text = collectionName
        bodyLabel.text = customCollection.body_html
        imageView.alpha = 0
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.load(url: self.customCollection.image.src)
        imageView.clipsToBounds = true
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView.alpha = 1
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.alpha = 0
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: tableView.frame.size.width * 0.5, y: tableView.frame.size.height * 0.5)
        activityIndicator.startAnimating()
        ProductInteractor.fetchCollects(customCollectionID: String(customCollection.id)) { (collectsReturned, error) in
            if let collects = collectsReturned, error == nil {
                var idStringArr = [String]()
                for product in collects {
                    idStringArr.append(String(product.product_id))
                }
                let productIDsConcatenated = idStringArr.joined(separator: ",")
                ProductInteractor.fetchProducts(productIDs: productIDsConcatenated, completion: { (productsReturned, error) in
                    if let products = productsReturned, error == nil {
                        self.productsArr = products
                        activityIndicator.stopAnimating()
                        activityIndicator.removeFromSuperview()
                        UIView.animate(withDuration: 0.4, animations: {
                            self.tableView.alpha = 1
                        })
                        self.tableView.reloadData()
                    }
                })
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
                let alert = UIAlertController(title: "Network Error", message: "Data unavailable", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension CollectionDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DetailTableViewCell
        cell.configure(product: productsArr[indexPath.row], collectionName: collectionName, collectionImage: imageView.image!)
        return cell
    }
}
