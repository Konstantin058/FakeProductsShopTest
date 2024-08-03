//
//  TabBarViewContoller.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
}

//MARK:  setup UI TabBarViewController
private extension TabBarViewController {
    
    func setupTabBar() {
        let productViewController = ProductViewController()
        let cartViewController = CartViewController()
        
        cartViewController.productViewModel = productViewController.productViewModel
        
        productViewController.tabBarItem.image = UIImage(systemName: "house")
        cartViewController.tabBarItem.image = UIImage(systemName: "cart")
        
        productViewController.tabBarItem.title = "Главная"
        cartViewController.tabBarItem.title = "Корзина"
        
        let productNavigationViewController = UINavigationController(rootViewController: productViewController)
        let cartNavigationViewController = UINavigationController(rootViewController: cartViewController)
        
        tabBar.tintColor = .green
        tabBar.backgroundColor = .white
        
        setViewControllers([productNavigationViewController, cartNavigationViewController], animated: true)
    }
}

/*
 3. При добавлении товара в корзину, бэйдж на таббаре иконки корзины, не сразу покаазывает количество товара в корзине, а только после перехода на экран корзины CartViewController. 
 */
