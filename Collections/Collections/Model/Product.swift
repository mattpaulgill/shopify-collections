//
//  Product.swift
//  Collections
//
//  Created by Matthew Gill on 3/20/19.
//  Copyright © 2019 Matthew Gill. All rights reserved.
//

import UIKit

struct AllProducts: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let id: Int
    let title, body_html, vendor, product_type: String
    let variants: [Variant]
    let image: ProductImage
}

struct Variant: Decodable {
    let id, product_id, inventory_quantity: Int
    let title, price: String
}

struct ProductImage: Decodable {
    let width, height: Int
    let src: URL
}
