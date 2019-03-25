//
//  CollectionListVC.swift
//  Collections
//
//  Created by Matthew Gill on 3/20/19.
//  Copyright © 2019 Matthew Gill. All rights reserved.
//

import UIKit

class CollectionListVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var collectionArr = [CustomCollection]()
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collections"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: tableView.frame.size.width * 0.5, y: tableView.frame.size.height * 0.5)
        activityIndicator.startAnimating()

        CollectionInteractor.fetchCollections { (customCollectionsReturned, error) in
            if let collections = customCollectionsReturned, error == nil {
                self.collectionArr = collections
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                    self.tableView.reloadData()
                }
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

extension CollectionListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let productNameFormatted = collectionArr[indexPath.row].title.replacingOccurrences(of: " collection", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        cell.textLabel?.text = productNameFormatted
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(CollectionDetailVC(collection: collectionArr[indexPath.row]), animated: true)
    }
}
