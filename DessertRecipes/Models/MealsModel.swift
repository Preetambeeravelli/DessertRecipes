//
//  MealsModel.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation

struct MealsModel: Codable{
    let meals: [Meals]
}
struct Meals: Codable, Identifiable, Comparable{
    let strMeal, strMealThumb, idMeal: String
    var id: String{
        idMeal
    }
    static func < (lhs: Meals, rhs: Meals) -> Bool {
        return lhs.strMeal < rhs.strMeal
    }
}
