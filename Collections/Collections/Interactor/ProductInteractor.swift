//
//  ProductInteractor.swift
//  Collections
//
//  Created by Matthew Gill on 3/24/19.
//  Copyright © 2019 Matthew Gill. All rights reserved.
//

import UIKit
import Alamofire

class ProductInteractor: NSObject {
    static func fetchCollects(customCollectionID: String, completion: @escaping (([Collect]?, Error?) -> Void)) {
        let url = "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\(customCollectionID)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        Alamofire.request(url).responseJSON { (response) in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(AllCollects.self, from: data)
                    completion(response.collects, nil)
                } catch {
                    completion(nil, response.error)
                    print(error)
                }
            }
        }
    }
    
    static func fetchProducts(productIDs: String, completion: @escaping (([Product]?, Error?) -> Void)) {
        let url = "https://shopicruit.myshopify.com/admin/products.json?ids=\(productIDs)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        Alamofire.request(url).responseJSON { (response) in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(AllProducts.self, from: data)
                    completion(response.products, nil)
                } catch {
                    completion(nil, response.error)
                    print(error)
                }
            }
        }
    }
}
