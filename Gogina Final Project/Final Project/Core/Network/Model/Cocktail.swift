//
//  Cocktail.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/13/23.
//

import Foundation

struct DrinkResponse: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let name: String?
    let image: String?
    let ingredients: [String]?
    let instructions: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case image = "strDrinkThumb"
        case ingredients
        case instructions
    }
}
