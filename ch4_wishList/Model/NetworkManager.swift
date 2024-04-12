//
//  NetworkManager.swift
//  ch4_wishList
//
//  Created by 한철희 on 4/12/24.
//

import Foundation

class NetworkManager {
    func fetchProduct(completion: @escaping ([Product]) -> Void) {
        let session = URLSession.shared
        
        let productID = Int.random(in: 0...100)
        
        if let url = URL(string: "https://dummyjson.com/products/\(productID)") {
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let product = try JSONDecoder().decode(Product.self, from: data)
                        completion([product])
                        
                        print("ID: \(product.id)")
                        print("Title: \(product.title)")
                        print("Description: \(product.description)")
                        print("Thumbnail: \(product.thumbnail)")
//                        print("Decoded Product: \(product)")
                    } catch {
                        print("Error : \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

