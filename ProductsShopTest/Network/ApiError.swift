//
//  ApiError.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

enum ApiError: String, Error {
    case urlError = "Ошибка вызова URL-адресса"
    case serverError = "Сервер не отвечает"
    case invalidResponse = "Ошибка запроса сети"
    case decodingError = "При декодировании произошла ошибка"
}
