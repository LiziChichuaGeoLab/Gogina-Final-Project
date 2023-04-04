//
//  Georgian.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/21/23.
//

import Foundation

struct GeorgianResponse: Codable {
    let meals: [Georgian]
}

struct Georgian: Codable {
    let name: String?
    let image: String?
    let video: String?
    let cal: Int?
    let ingredients: [String]?
    let instructions: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case image = "strMealThumb"
        case video = "instructionVideo"
        case cal
        case ingredients
        case instructions
    }
}
