//
//  NetworkManager.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation
import Combine

//Generic Class to manage network requests which takes a generic T which conforms to Codable protocol
class NetworkManager<T: Codable>{
    //Type of request to be made
    var requestType: RequestType
    
    //Initializer for the class
    init(requestType: RequestType) {
        self.requestType = requestType
    }
    
    //Creates a url string from the specified request type
    var urlString: String {
        switch requestType {
        case .Category(let category):
            return "\(URLS.CategoryFilter.rawValue)\(category)"
        case .RecipeDetailWithMealID(let mealId):
            return "\(URLS.MealDetail.rawValue)\(mealId)"
        }
    }
    
    //function to make a network request and return a publisher
    func makeRequest() -> AnyPublisher<T, NetworkError> {
        //Chekcing if we get a url from the string
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.BadURL).eraseToAnyPublisher()
        }
        //Creating a url request with the url
        let urlRequest = URLRequest(url: url)
        
        //using urlsession to create a publisher for the url request
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
