//
//  ProductCollectionViewCell.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit
import SnapKit

enum CartProductAction {
    case addProduct(Product)
    case removeProduct(Product)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    private let productView = UIView()
    private let productTitleLabel = LabelType(type: .title)
    private let priceLabel = LabelType(type: .price)
    private let productImageView = UIImageView()
    private let buyButton = UIButton()
    
    var cartProductAction: ((CartProductAction) -> Void)?
    var cartProductStatus: Bool = false
    
    var product: Product? {
        didSet {
            configureUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup UI
private extension ProductCollectionViewCell {
    
    func setupUI() {
        setupView()
        setupImageView()
        setupButton()
        addSubViews()
        makeConstrains()
    }
    
    func setupView() {
        productView.backgroundColor = .white.withAlphaComponent(0.8)
        productView.clipsToBounds = false
        productView.layer.cornerRadius = 15
        productView.layer.borderWidth = 1
        productView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupImageView() {
        productImageView.layer.masksToBounds = true
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = 15
    }
    
    func setupButton() {
        buyButton.setImage(UIImage(systemName: "plus"), for: .normal)
        buyButton.backgroundColor = .gray.withAlphaComponent(0.6)
        buyButton.tintColor = .red
        buyButton.layer.cornerRadius = 10
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
    }
    
    func addSubViews() {
       contentView.addSubview(productView)
        
        [productTitleLabel, priceLabel, productImageView, buyButton].forEach {
            productView.addSubview($0)
        }
    }
    
    func makeConstrains() {
        productView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            make.width.equalTo(170)
            make.height.equalTo(236)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(3)
            make.width.equalTo(130)
            make.height.equalTo(90)
        }

        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(5)
            make.width.equalTo(150)
            make.height.equalTo(36)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(10)
        }

        buyButton.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(30)
            make.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(10)
            make.size.equalTo(44)
        }
    }
    
    func configureUI() {
        guard let product else { return }
        
        productTitleLabel.text = product.title
        priceLabel.text = "\(product.price)Р"
        productImageView.setImage(with: product.image)
    }
    
    @objc func buyButtonTapped() {
        
        cartProductStatus.toggle()
        
        animationButton()
        
        if let product {
            let callBackAction: CartProductAction = cartProductStatus ? .addProduct(product) : .removeProduct(product)
            cartProductAction?(callBackAction)
        }
        print("Кнопка заказать была нажата")
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

