//
//  EnumConstants.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation

// Enum to specify different types of network requests
enum RequestType {
    // Case for requesting meals by category, takes a category string as an associated value
    case Category(String)
    // Case for requesting meal details by meal ID, takes a meal ID string as an associated value
    case RecipeDetailWithMealID(String)
}

// Enum to represent different types of network errors
enum NetworkError: Error {
    // Case for an invalid URL error
    case BadURL
    // Case for a no data error
    case NoData
    // Case for a decoding error, takes the underlying error as an associated value
    case DecodingError(Error)
    // Case for a request failure, takes the underlying error as an associated value
    case RequestFailed(Error)
}

// Enum to represent specific meal-related errors
enum MealErrors: String {
    // Case for when no meal is found
    case NoMealFound = "No meal found"
}

// Enum to represent different base URLs for the API
enum URLS: String {
    // Case for the category filter URL
    case CategoryFilter = "https://themealdb.com/api/json/v1/1/filter.php?c="
    // Case for the meal detail URL
    case MealDetail = "https://themealdb.com/api/json/v1/1/lookup.php?i="
}

