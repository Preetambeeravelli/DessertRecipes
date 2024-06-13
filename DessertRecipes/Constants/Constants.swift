//
//  Constants.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation

// Enum for general application constants
enum AppConstants: String {
    // Case representing a loading state
    case Loading
}

// Enum for text constants used in the application
enum AppTextConstants: String {
    // Case for the title of dessert recipes section
    case DessertRecipes = "Dessert Recipes"
    // Case for the instructions label
    case Instructions
    // Case for the ingredients label
    case Ingredients
}

// Enum for property name constants
enum PropertyNameConstants: String {
    // Case for the measure property name base
    case strMeasure
    // Case for the ingredient property name base
    case strIngredient
}

// Enum to differentiate between types of properties (ingredient or measurement)
enum PropertyName {
    // Case for ingredient properties.
    case Ingredient
    // Case for measurement properties.
    case Measurement
}

// Enum for meal categories
enum MealCategories: String {
    // Case for the dessert category.
    case Dessert
}
