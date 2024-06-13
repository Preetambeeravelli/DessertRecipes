//
//  MealsModel.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation

// Struct of the top-level meals model
struct MealsModel: Codable {
    // An array of meal objects.
    let meals: [Meals]
}

// Struct representing Meals
struct Meals: Codable, Identifiable, Comparable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    // Computed property to conform to the Identifiable protocol
    var id: String {
        idMeal
    }
    
    // Static function to conform to the Comparable protocol for sorting meals alphabetically by name
    static func < (lhs: Meals, rhs: Meals) -> Bool {
        return lhs.strMeal < rhs.strMeal
    }
}
