//
//  NetworkManager.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/13/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Codable>(url: String, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
