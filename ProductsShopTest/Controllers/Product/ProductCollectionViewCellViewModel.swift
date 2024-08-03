//
//  ProductCollectionViewCellViewModel.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

class ProductCellViewModel {
    
    var id: Int
    var title: String
    var image: String
    var price: String
    
    init(product: Product) {
        self.id = product.id
        self.title = product.title
        self.image = product.image
        self.price = "\(product.price)"
    }
}

