//
//  CartTableViewCell.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit
import SnapKit

class CartTableViewCell: UITableViewCell {
    
    static let identifier = "CartTableViewCell"
    
    private let container = UIView()
    private let buttonView = UIView()
    private let cartImageView = UIImageView()
    private let cartTitleLabel = LabelType(type: .title)
    private let cartPricelabel = LabelType(type: .price)
    private let quantityLabel = LabelType(type: .quantity)
    private let cartPlusButton = UIButton()
    private let cartMinusButton = UIButton()
    private let cartDeleteButton = UIButton()
    
    var totalPriceAction: ((Int) -> Void)?
    var deleteProductAction: ((Product) -> Void)?
    
    var quantityProduct: Int = 1
    var pricePerProduct: Double = 0.0
    
    var product: Product? {
        didSet {
            configureUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup UI
extension CartTableViewCell {
    
    func setupUI() {
        setupView()
        setupImage()
        setupLabel()
        setupButtons()
        addSubViews()
        makeConstraints()
    }
    
    func setupView() {
        container.backgroundColor = .white.withAlphaComponent(0.8)
        container.clipsToBounds = false
        container.layer.cornerRadius = 15
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.lightGray.cgColor
        
        buttonView.backgroundColor = .lightGray
        buttonView.clipsToBounds = false
        buttonView.layer.cornerRadius = 15
    }
    
    func setupImage() {
        cartImageView.layer.masksToBounds = true
        cartImageView.contentMode = .scaleAspectFill
    }
    
    func setupLabel() {
        quantityLabel.text = "\(quantityProduct)"
    }
    
    func setupButtons() {
        cartPlusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        cartPlusButton.tintColor = .gray
        cartPlusButton.addTarget(self, action: #selector(cartPlusButtonTapped), for: .touchUpInside)
        
        cartMinusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        cartMinusButton.tintColor = .gray
        cartMinusButton.addTarget(self, action: #selector(cartMinusButtonTapped), for: .touchUpInside)
        
        cartDeleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cartDeleteButton.tintColor = .black
        cartDeleteButton.addTarget(self, action: #selector(cartDeleteButtonTapped), for: .touchUpInside)
    }
    
    func addSubViews() {
        contentView.addSubview(container)
        
        [cartImageView, cartTitleLabel, cartPricelabel, buttonView, cartDeleteButton].forEach {
            container.addSubview($0)
        }
        
        [quantityLabel, cartPlusButton, cartMinusButton].forEach {
            buttonView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        cartImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(118)
            make.height.equalTo(76)
        }
        
        cartTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalTo(cartImageView.snp.right).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(36)
        }
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(cartTitleLabel.snp.bottom).offset(30)
            make.left.equalTo(cartImageView.snp.right).offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(96)
            make.height.equalTo(44)
        }
        
        cartMinusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.size.equalTo(24)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(24)
        }
        
        cartPlusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.size.equalTo(24)
        }
        
        cartDeleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.size.equalTo(24)
        }
        
        cartPricelabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }

    func configureUI() {
        guard let product else { return }
        cartImageView.setImage(with: product.image)
        cartTitleLabel.text = product.title
        pricePerProduct = product.price
        updatePriceLabel()
    }
    
    func updatePriceLabel() {
        let totalPrice = pricePerProduct * Double(quantityProduct)
        cartPricelabel.text = "\(totalPrice)P"
    }
    
    @objc func cartPlusButtonTapped() {
        guard var product = product else { return }
        quantityProduct += 1
        product.quantity = quantityProduct
        self.product = product
        updatePriceLabel()
        quantityLabel.text = "\(quantityProduct)"
        totalPriceAction?(quantityProduct)
    }
    
    @objc func cartMinusButtonTapped() {
        guard var product = product, quantityProduct > 1 else { return }
        quantityProduct -= 1
        product.quantity = quantityProduct
        self.product = product 
        updatePriceLabel()
        quantityLabel.text = "\(quantityProduct)"
        totalPriceAction?(quantityProduct)
    }
    
    @objc func cartDeleteButtonTapped() {
        guard let product = product else { return }
        deleteProductAction?(product)
    }
}
