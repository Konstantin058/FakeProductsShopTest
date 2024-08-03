//
//  ProductViewController.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit
import SnapKit

class ProductViewController: UIViewController {
    
    var productViewModel = ProductViewModel()
    private var productDetails: [ProductCellViewModel] = []
    
    private let productCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        setupUI()
    }
}

//MARK: Setup UI
extension ProductViewController {
    
    func setupUI() {
        setupNavbarItem()
        setupCollectionView()
        loadProductData()
        bindDetailViewModel()
    }
    
    func setupNavbarItem() {
        self.navigationItem.title = "Одежда"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(userButtonTaped))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func setupCollectionView() {
        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        view.addSubview(productCollectionView)
        
        productCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func loadProductData() {
        DispatchQueue.main.async {
            self.productViewModel.fetchProducts()
            self.productViewModel.productDelegate = self
        }
    }
    
    func bindDetailViewModel() {
        productViewModel.products.bind { [weak self] product in
            guard let self = self,
                  let product = product else {
                return
            }
            
            DispatchQueue.main.async {
                self.productDetails = product
            }
        }
    }
    
    func cartProductCallBack(action: CartProductAction) {
        switch action {
        case let .addProduct(product):
            productViewModel.cartProducts.value?.append(product)
        case let .removeProduct(product):
            productViewModel.cartProducts.value?.removeAll { $0.id == product.id }
        }
    }
    
    func openDetails(productId: Int) {
        guard let product = productViewModel.retriveProduct(withId: productId) else {
            return
        }
        
        DispatchQueue.main.async {
            let detailsViewModel = DetailProductViewModel(product: product)
            let detailViewController = DetailViewController(viewModel: detailsViewModel)
            detailViewController.product = product
            detailViewController.productViewModel = self.productViewModel
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    @objc func userButtonTaped() {
       
    }
}
    
//MARK: Service
extension ProductViewController: Service {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
}
    
//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModel.product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        let productContent = productViewModel.product.safeObject(at: indexPath.row)
        cell.product = productContent
        cell.cartProductAction = cartProductCallBack
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 170, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productId = productViewModel.product[indexPath.row].id
        self.openDetails(productId: productId)
    }
}



