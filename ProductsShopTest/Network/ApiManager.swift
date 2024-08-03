//
//  ApiManager.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

class ApiManager: ApiRequest {
    
    func apiRequest<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, ApiError>) -> Void) {
        guard let url = url else {
            completion(.failure(.urlError))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error as! ApiError))
                } else {
                    completion(.failure(.serverError))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}

