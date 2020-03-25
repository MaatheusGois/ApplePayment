//
//  Shoe.swift
//  applePay
//
//  Created by Matheus Silva on 25/03/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation

struct Shoe {
    var name: String
    var price: Double
    
    static func shoesExample() -> Shoes {
        return [
            Shoe(name: "Nike Air Force 1 High LV8", price: 110.00),
            Shoe(name: "adidas Ultra Boost Clima", price: 139.99),
            Shoe(name: "Jordan Retro 10", price: 190.00),
            Shoe(name: "adidas Originals Prophere", price: 49.99),
            Shoe(name: "New Balance 574 Classic", price: 90.00)
        ]
    }
}

///This declare the shoes to Array of *Shoe*
typealias Shoes = [Shoe]
