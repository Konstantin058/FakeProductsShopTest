//
//  Protocol.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

protocol Service: AnyObject {
    func reloadData()
}

protocol ApiRequest {
    func apiRequest<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, ApiError>) -> Void)
}
