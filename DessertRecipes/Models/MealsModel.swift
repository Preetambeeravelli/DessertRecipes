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
struct Meals: Codable, Identifiable{
    let strMeal, strMealThumb, idMeal: String
    var id: String{
        idMeal
    }
}
