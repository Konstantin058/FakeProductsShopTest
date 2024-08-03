//
//  Collection+Extension.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

//MARK: Collection
extension Collection {

    subscript(safe index: Index) -> Element? {
        return safeObject(at: index)
    }

    func safeObject(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

