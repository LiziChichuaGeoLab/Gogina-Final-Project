//
//  MealManager.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/13/23.
//

import Foundation

/*
 https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
 https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian
 */

/*
 // Seafood
 https://run.mocky.io/v3/92e2131a-baa8-49a4-bfe2-42bf6260f3f8
 https://run.mocky.io/v3/92e2131a-baa8-49a4-bfe2-42bf6260f3f8
 // Canadian
 https://run.mocky.io/v3/4d6eee3d-1ae4-4d6c-b882-f102102ac931?fbclid=IwAR0tRoLIUocxoC9-qKIUako1LrYrHFMetL6vmHgTLYNzXHK-wF_R208IF5s
 https://run.mocky.io/v3/4d6eee3d-1ae4-4d6c-b882-f102102ac931?fbclid=IwAR0tRoLIUocxoC9-qKIUako1LrYrHFMetL6vmHgTLYNzXHK-wF_R208IF5s
 */

enum MealType: Int {
    case seafood = 0
    case canadian
    
    var endPoint: String {
        switch  self {
        case .seafood:
            return "https://run.mocky.io/v3/92e2131a-baa8-49a4-bfe2-42bf6260f3f8"
        case .canadian:
            return "https://run.mocky.io/v3/4d6eee3d-1ae4-4d6c-b882-f102102ac931?fbclid=IwAR0tRoLIUocxoC9-qKIUako1LrYrHFMetL6vmHgTLYNzXHK-wF_R208IF5s"
        }
    }
}

protocol MealManagerProtocol {
    func fetchMeal(with type: MealType, completion: @escaping(Result<MealResponse, Error>) -> ())
}

class MealManager: MealManagerProtocol {
    func fetchMeal(with type: MealType, completion: @escaping (Result<MealResponse, Error>) -> ()) {
        NetworkManager.shared.get(url: "\(type.endPoint)") { (result: Result<MealResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
