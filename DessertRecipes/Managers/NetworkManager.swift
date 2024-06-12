//
//  NetworkManager.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation
import Combine

class NetworkManager<T: Codable>{
    var requestType: RequestType
    
    init(requestType: RequestType) {
        self.requestType = requestType
    }
    
    var urlString: String {
        switch requestType {
        case .Category(let category):
            return "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        case .RecipeDetailWithMealID(let mealId):
            return "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
        }
    }
    
    func makeRequest() -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.BadURL).eraseToAnyPublisher()
        }
        
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { NetworkError.RequestFailed($0) }
            .flatMap { data, response -> AnyPublisher<T, NetworkError> in
                Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { NetworkError.DecodingError($0) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
