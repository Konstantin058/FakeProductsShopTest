//
//  UIImageView + Extension.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit
import Kingfisher

//MARK: UIImageView
extension UIImageView {
    func setImage(with urlString: String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
