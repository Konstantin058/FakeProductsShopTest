//
//  UIViewController+Exstension.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 22.07.2024.
//

import UIKit

extension UIViewController {
    
    func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.2,
                       animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.2) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
}

