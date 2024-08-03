//
//  CustomLabel.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

enum Label {
    case signIn
    case signUp
    case login
    case email
    case password
    case title
    case description
    case category
    case price
    case priceText
    case quantity
    case totalTextPrice
    case totalPrice
}

class LabelType: UILabel {
    
    private let type: Label
    
    init(type: Label) {
        self.type = type
        super.init(frame: .zero)
        
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup UI
private extension LabelType {
    
    func setupLabel() {
        switch type {
        case .title:
            textAlignment = .left
            font = .boldSystemFont(ofSize: 16)
            textColor = .black
        case .description:
            textAlignment = .left
            font = .boldSystemFont(ofSize: 14)
            numberOfLines = 0
            textColor = .gray
        case .category:
            textAlignment = .left
            font = .boldSystemFont(ofSize: 10)
            textColor = .gray.withAlphaComponent(0.8)
        case .price:
            textAlignment = .right
            font = .boldSystemFont(ofSize: 18)
            textColor = .red
        case .priceText:
            textAlignment = .left
            font = .boldSystemFont(ofSize: 18)
            textColor = .black
        case .quantity:
            textAlignment = .center
            font = .systemFont(ofSize: 10)
            textColor = .black
        case .totalTextPrice:
            textAlignment = .left
            font = .systemFont(ofSize: 18)
            textColor = .red
        case .totalPrice:
            textAlignment = .center
            font = .systemFont(ofSize: 18)
            textColor = .red
        case .login:
            text = "Логин"
            textAlignment = .left
            font = .systemFont(ofSize: 18)
            textColor = .black
        case .email:
            text = "Email"
            textAlignment = .left
            font = .systemFont(ofSize: 18)
            textColor = .black
        case .password:
            text = "Пароль"
            textAlignment = .left
            font = .systemFont(ofSize: 18)
            textColor = .black
        case .signIn:
            text = "Вход"
            textAlignment = .center
            font = .systemFont(ofSize: 24, weight: .black)
            textColor = .black
        case .signUp:
            text = "Регистрация"
            textAlignment = .center
            font = .systemFont(ofSize: 24, weight: .black)
            textColor = .black
        }
    }
}
