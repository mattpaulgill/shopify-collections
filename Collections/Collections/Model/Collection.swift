//
//  Collection.swift
//  Collections
//
//  Created by Matthew Gill on 3/20/19.
//  Copyright © 2019 Matthew Gill. All rights reserved.
//

import UIKit

struct AllCollections: Decodable {
    let custom_collections: [CustomCollection]
}

struct CustomCollection: Decodable {
    let id: Int
    let title: String
    let body_html: String
    let image: Image
}

struct Image: Decodable {
    let created_at: String
    let width, height: Int
    let src: URL
}

struct AllCollects: Decodable {
    let collects: [Collect]
}

struct Collect: Decodable {
    let id, collection_id, product_id: Int
    let featured: Bool
    let position: Int
    let sort_value: String
}
