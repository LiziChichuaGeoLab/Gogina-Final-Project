//
//  CocktailManager.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/13/23.
//

/*
 https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic
 https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic
 https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail
 */

/*
 alcoholic
 https://run.mocky.io/v3/ca651ffa-f677-4355-90b5-be38a50a5787
 https://run.mocky.io/v3/ca651ffa-f677-4355-90b5-be38a50a5787
 Non Alcoholic
 https://run.mocky.io/v3/01266b5b-df89-4f0c-aa7a-004ae4f0a74c
 https://run.mocky.io/v3/01266b5b-df89-4f0c-aa7a-004ae4f0a74c
 Cocktails
 https://run.mocky.io/v3/5dd3b792-08ee-4c66-9f8e-b22b87d32330
 https://run.mocky.io/v3/5dd3b792-08ee-4c66-9f8e-b22b87d32330
 */

import Foundation

enum DrinkType: Int {
    case alcoholic = 0
    case nonAlcoholic
    case cocktail
    
    var endPoint: String {
        switch self {
        case .alcoholic:
            return "https://run.mocky.io/v3/ca651ffa-f677-4355-90b5-be38a50a5787"
        case .nonAlcoholic:
            return "https://run.mocky.io/v3/01266b5b-df89-4f0c-aa7a-004ae4f0a74c"
        case .cocktail:
            return "https://run.mocky.io/v3/5dd3b792-08ee-4c66-9f8e-b22b87d32330"
        }
    }
}

protocol CocktailManagerProtocol {
    func fetchDrinks(with type: DrinkType ,completion: @escaping (Result<DrinkResponse, Error>) -> ())
}

class CocktailManager: CocktailManagerProtocol {
    func fetchDrinks(with type: DrinkType, completion: @escaping (Result<DrinkResponse, Error>) -> ()) {
        NetworkManager.shared.get(url: "\(type.endPoint)") { (result: Result<DrinkResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
