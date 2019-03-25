//
//  DetailTableViewCell.swift
//  Collections
//
//  Created by Matthew Gill on 3/21/19.
//  Copyright © 2019 Matthew Gill. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var productIDLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var inventoryLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    let lowInventoryWarningLimit = 100
    
    func configure(product: Product, collectionName: String, collectionImage: UIImage) {
        let productNameFormatted = product.title.replacingOccurrences(of: collectionName, with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        productImageView.layer.cornerRadius = 10
        productImageView.layer.borderWidth = 1
        productImageView.layer.borderColor = UIColor.lightGray.cgColor
        productImageView.load(url: product.image.src)
        productImageView.clipsToBounds = true
        titleLabel.text = productNameFormatted
        vendorLabel.text = product.vendor
        productIDLabel.text = "ID: " + String(product.id)
        productTypeLabel.text = "Type: " + product.product_type
        collectionLabel.text = collectionName
        collectionImageView?.image = collectionImage
        collectionImageView?.layer.cornerRadius =
            (collectionImageView?.frame.size.width)! / 2
        collectionImageView?.clipsToBounds = true
        collectionImageView?.contentMode = .scaleAspectFill
        collectionImageView?.layer.borderWidth = 1
        collectionImageView?.layer.borderColor = UIColor.lightGray.cgColor
        selectionStyle = .none
        var totalInventory = 0
        for variant in product.variants {
            totalInventory += Int(variant.inventory_quantity)
        }
        inventoryLabel.textColor = totalInventory < lowInventoryWarningLimit ? UIColor.red : UIColor.black
        inventoryLabel.text = "\(totalInventory) in stock"
    }
}
