//
//  MealDetailViewModel.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation
import Combine

@MainActor
class MealDetailViewModel: ObservableObject{
    @Published var mealDetail: MealDetail?
    @Published var errorMessage: String?
    @Published var ingredientsWithMeasures: [String: String] = [:]
    private let networkManager: NetworkManager<MealDetailModel>
    private var cancellables: Set<AnyCancellable> = []
    
    init(mealID: String) {
        self.networkManager = NetworkManager(requestType: .RecipeDetailWithMealID(mealID))
    }
    
    func fetchMeals() {
        networkManager.makeRequest()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = "Request failed with error: \(error)"
                }
            }, receiveValue: { [weak self] mealDetailModel in
                guard let meal = mealDetailModel.meals.first else {
                    self?.errorMessage = "No meal found"
                    return
                }
                self?.mealDetail = meal
                self?.createIngredientsWithMeasures(from: meal)
            })
            .store(in: &cancellables)
    }

    private func createIngredientsWithMeasures(from mealDetail: MealDetail)  {
        var ingredientsWithMeasures = [String: String]()
        
        for index in 1...20 {
            if let ingredient = getIngredientAndMeasurements(for: index, from: mealDetail, propertyname: .Ingredient),
               let measure = getIngredientAndMeasurements(for: index, from: mealDetail, propertyname: .Measurement) {
                ingredientsWithMeasures[ingredient] = measure
            }
        }
        self.ingredientsWithMeasures = ingredientsWithMeasures
    }
    
    private func getIngredientAndMeasurements(for index: Int, from mealDetail: MealDetail, propertyname: PropertyName) -> String?{
        let mirror = Mirror(reflecting: mealDetail)
        var propertyName: String{
            switch propertyname{
            case .Ingredient:
                return "strIngredient\(index)"
            case .Measurement:
                return "strMeasure\(index)"
            }
        }
        for child in mirror.children {
            if child.label == propertyName,
               let value = child.value as? String,
               !value.trimmingCharacters(in: .whitespaces).isEmpty {
                return value
            }
        }
        return nil
    }
}
