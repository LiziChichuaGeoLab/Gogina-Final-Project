//
//  GeorgianManager.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/21/23.
//

/*
 //  popular
 https://run.mocky.io/v3/bc328c75-2875-403f-9c38-fe4f79bc4fcb?fbclid=IwAR1Pu9m0uA8g8lDBIpKzAINQUuS06fHHa5eLIumNDKa_gwfNYWB2wP6R4_w
 // comeuli
 https://run.mocky.io/v3/b9e187da-8db4-44b4-95a3-33987b4e1fbd?fbclid=IwAR3IbdpDC1WQYq1P_fKu3PsHUETdSUJyWLwZmYCHyrGkjgCZe8b99BMJ5DA
 // saaxalwlo
 https://run.mocky.io/v3/c57b182e-3093-4c16-8d8e-381855fb2aa4?fbclid=IwAR3dFMMLawa44sO-FFNS-dmFLWbX3PAMeirK3mx-buWUArtqIi7pEp_EFUs
 */

import Foundation

enum GeoType: Int, CaseIterable {
    case popular = 0
    case baked
    case christmas
    
    var returnParam: String {
        switch self {
        case .popular:
            return "https://run.mocky.io/v3/bc328c75-2875-403f-9c38-fe4f79bc4fcb?fbclid=IwAR1Pu9m0uA8g8lDBIpKzAINQUuS06fHHa5eLIumNDKa_gwfNYWB2wP6R4_w"
        case .baked:
            return "https://run.mocky.io/v3/b9e187da-8db4-44b4-95a3-33987b4e1fbd?fbclid=IwAR3IbdpDC1WQYq1P_fKu3PsHUETdSUJyWLwZmYCHyrGkjgCZe8b99BMJ5DA"
        case .christmas:
            return "https://run.mocky.io/v3/c57b182e-3093-4c16-8d8e-381855fb2aa4?fbclid=IwAR3dFMMLawa44sO-FFNS-dmFLWbX3PAMeirK3mx-buWUArtqIi7pEp_EFUs"
        }
    }
}

protocol GeorgianManagerProtocol {
    func fetchGeoFood(with type: GeoType, completion: @escaping (Result<GeorgianResponse, Error>) -> ())
}

class GeorgianManager: GeorgianManagerProtocol {
    func fetchGeoFood(with type: GeoType, completion: @escaping (Result<GeorgianResponse, Error>) -> ()) {
        NetworkManager.shared.get(url: "\(type.returnParam)") { (result: Result<GeorgianResponse, Error>) in
            switch  result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
