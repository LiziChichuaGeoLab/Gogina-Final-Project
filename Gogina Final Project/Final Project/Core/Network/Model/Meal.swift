//
//  Meal.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/13/23.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let name: String?
    let image: String?
    let ingredients: [String]?
    let instructions: [String]?
    let calories: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case image = "strMealThumb"
        case calories = "cal"
        case ingredients
        case instructions
    }
}
