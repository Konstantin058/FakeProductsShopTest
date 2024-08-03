//
//  CartTableCellViewModel.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

class CartTableCellViewModel {
    
    var product: Product
    
    var productid: Int
    var productImage: String
    var productTitle: String
    var productPrice: String
    
    init(product: Product) {
        self.product = product
        
        self.productid = product.id
        self.productImage = product.image
        self.productTitle = product.title
        self.productPrice = "\(product.price) P"
    }
}


