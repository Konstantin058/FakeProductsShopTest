//
//  Observable.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import Foundation

class Observable<T> {

    var value: T? {
        didSet {
            DispatchQueue.main.async {
                print("Значение Observable изменилось на: \(String(describing: self.value))")
                self.listener?(self.value)
            }
        }
    }

    init( _ value: T?) {
        self.value = value
    }

    private var listener: ((T?) -> Void)?

    func bind( _ listener: @escaping ((T?) -> Void)) {
        listener(value)
        print("Добавлен новый слушатель")
        self.listener = listener
        
    }
}
