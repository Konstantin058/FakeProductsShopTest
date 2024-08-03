//
//  ProductViewModel.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

class ProductViewModel {
    
    var product: [Product] = [] {
        didSet {
            self.productDelegate?.reloadData()
        }
    }
    
    var products: Observable<[ProductCellViewModel]> = Observable(nil)
    var cartProducts: Observable<[Product]> = Observable([])
    
    weak var productDelegate: Service?
    private let manager = ApiManager()
    
    func fetchProducts() {
        manager.apiRequest(url: Constant.productURL, expecting: [Product].self) { [weak self] result in
            switch result {
            case .success(let newProduct):
                DispatchQueue.main.async {
                    self?.product = newProduct
                    self?.mapProductData()
                }
            case .failure(let error):
                print("Error viewModel: \(error)")
            }
        }
    }
    
    private func mapProductData() {
        products.value = self.product.compactMap({ProductCellViewModel(product: $0)})
    }
    
    func retriveProduct(withId id: Int) -> Product? {
        guard let product = product.first(where:  { $0.id == id }) else { return nil }
        
        return product
    }
    
    func addProductToCart(_ product: Product) {
        cartProducts.value?.append(product)
    }
    
    func removeProductFromCart(_ product: Product) {
        cartProducts.value?.removeAll { $0.id == product.id }
    }
}

