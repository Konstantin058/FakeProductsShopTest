//
//  ProductModel.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    var quantity: Int = 1
    
    enum CodingKeys: String, CodingKey {
           case id
           case title
           case price
           case description
           case category
           case image
       }
}
