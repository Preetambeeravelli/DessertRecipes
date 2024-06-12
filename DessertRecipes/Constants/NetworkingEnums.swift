//
//  EnumConstants.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation

enum RequestType {
    case Category(String)
    case RecipeDetailWithMealID(String)
}

enum NetworkError: Error {
    case BadURL
    case NoData
    case DecodingError(Error)
    case RequestFailed(Error)
}

enum MealErrors: String{
    case NoMealFound = "No meal found"
}
