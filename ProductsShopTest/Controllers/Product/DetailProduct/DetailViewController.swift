//
//  DetailViewController.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
   
    private let productImageView = UIImageView()
    private let productTitleLabel = LabelType(type: .title)
    private let productDescriptionlabel = LabelType(type: .description)
    private let productPriceLabel = LabelType(type: .price)
    private let productpriceText = LabelType(type: .priceText)
    private let buyButton = UIButton()

    var product: Product? {
        didSet {
            configureView()
        }
    }
    
    var detailViewModel: DetailProductViewModel
    var productViewModel: ProductViewModel?
  
    var cartProductAction: ((CartProductAction) -> Void)?
    var cartProductStatus: Bool = false
    
    init(viewModel: DetailProductViewModel) {
        self.detailViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        cartProductAction = cartProductCallBack(action:)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cartProductAction = cartProductCallBack(action:)
    }
}

//MARK: Setup UI
private extension DetailViewController {
    
    func setupUI() {
        setupNavbarItem()
        setupImageView()
        setupLabel()
        setupButton()
        addSubViews()
        makeConstrains()
        configureView()
    }
    
    func setupNavbarItem() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
    }
    
    func setupImageView() {
        productImageView.layer.masksToBounds = true
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = 15
    }
    
    func setupLabel() {
        productpriceText.text = "Стоимость:"
    }
    
    func setupButton() {
        buyButton.setTitle("Заказать", for: .normal)
        buyButton.backgroundColor = .red
        buyButton.layer.cornerRadius = 8
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
    }
    
    func addSubViews() {
        [productImageView, productTitleLabel, productPriceLabel, productDescriptionlabel, productpriceText, buyButton].forEach {
            view.addSubview($0)
        }
    }
    
    func makeConstrains() {
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(140)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }

        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).inset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(50)
        }

        productDescriptionlabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).inset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
        
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productDescriptionlabel.snp.bottom).inset(-60)
            make.right.equalToSuperview().inset(20)
        }
        
        productpriceText.snp.makeConstraints { make in
            make.top.equalTo(productDescriptionlabel.snp.bottom).inset(-60)
            make.left.equalToSuperview().inset(20)
        }

        buyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(120)
            make.width.equalTo(343)
            make.height.equalTo(44)
        }
    }
    
    func configureView() {
        self.title = "Детали товара"
        productImageView.setImage(with: detailViewModel.productImage)
        productTitleLabel.text = detailViewModel.productTitle
        productDescriptionlabel.text = detailViewModel.productDescription
        productPriceLabel.text = detailViewModel.productPrice
    }
    
//    func cartProductCallBack(action: CartProductAction) {
//        switch action {
//        case let .addProduct(product):
//            productViewModel?.cartProducts.value?.append(product)
//        case let .removeProduct(product):
//            productViewModel?.cartProducts.value?.removeAll { $0.id == product.id }
//        }
//    }
    
    func cartProductCallBack(action: CartProductAction) {
        print("Действие с продуктом в корзине: \(action)")
        switch action {
        case let .addProduct(product):
            print("Добавление продукта: \(product.title)")
            productViewModel?.addProductToCart(product)
        case let .removeProduct(product):
            print("Удаление продукта: \(product.title)")
            productViewModel?.removeProductFromCart(product)
        }
    }
    
    @objc func buyButtonTapped() {
        print("Кнопка заказать была нажата")
        cartProductStatus.toggle()

        animationButton()

        if let product {
            let callBackAction: CartProductAction = cartProductStatus ? .addProduct(product) : .removeProduct(product)
            cartProductAction?(callBackAction)
        }
    }

    func animationButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.buyButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.buyButton.transform = CGAffineTransform.identity
            })
        }
    }
}
