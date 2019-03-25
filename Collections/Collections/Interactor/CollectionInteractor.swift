//
//  CollectionInteractor.swift
//  Collections
//
//  Created by Matthew Gill on 3/24/19.
//  Copyright © 2019 Matthew Gill. All rights reserved.
//

import UIKit
import Alamofire

class CollectionInteractor: NSObject {
    static func fetchCollections(completion: @escaping (([CustomCollection]?, Error?) -> Void)) {
        let url = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        Alamofire.request(url).responseJSON { (response) in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(AllCollections.self, from: data)
                    completion(response.custom_collections, nil)
                } catch {
                    completion(nil, response.error)
                    print(error)
                }
            }
        }
    }
}
