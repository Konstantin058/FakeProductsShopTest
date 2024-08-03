//
//  DetailViewModel.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

class DetailProductViewModel {
    
    var product: Product
 
    var productImage: String
    var productTitle: String
    var productDescription: String
    var productPrice: String
    var productId: Int
    
    init(product: Product) {
        self.product = product
        
        self.productId = product.id
        self.productTitle = product.title
        self.productImage = product.image
        self.productDescription = product.description
        self.productPrice = "\(product.price)P"
    }
}

