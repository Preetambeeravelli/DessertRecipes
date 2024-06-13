//
//  MealDetailViewModel.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation
import Combine

class MealDetailViewModel: ObservableObject{
    // Published property to store the meal fetched
    @Published var mealDetail: MealDetail?
    // Published property to store any error message
    @Published var errorMessage: String?
    // Published property to store ingredients with their corresponding measurements
    @Published var ingredientsWithMeasures: [String: String] = [:]
    //Creating a network manager object to make request
    private let networkManager: NetworkManager<MealDetailModel>
    //Set to hold cancellable references
    private var cancellables: Set<AnyCancellable> = []
    
    //Initializer that takes mealId used to initialize networkManager object
    init(mealID: String) {
        self.networkManager = NetworkManager(requestType: .RecipeDetailWithMealID(mealID))
    }
    
    // Function to fetch mealdetails from the network from view
    func fetchMealDetail() {
        // Making a network request using the network manager
        networkManager.makeRequest()
        // Receiving the results on the main dispatch queue to update the UI
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // If there's an error, update the errorMessage property
                    self?.errorMessage = "\(error)"
                }
            }, receiveValue: { [weak self] mealDetailModel in
                // On receiving the value, extract the first meal detail
                guard let meal = mealDetailModel.meals.first else {
                    self?.errorMessage = MealErrors.NoMealFound.rawValue
                    return
                }
                // Update the mealDetail property with the received meal detail
                self?.mealDetail = meal
                // Create a dictionary of ingredients with their corresponding measurements
                self?.createIngredientsWithMeasures(from: meal)
            })
        // Storing the subscription in the set
            .store(in: &cancellables)
    }
    
    // Function to create a dictionary of ingredients with their corresponding measurements from the meal detail
    private func createIngredientsWithMeasures(from mealDetail: MealDetail) {
        var ingredientsWithMeasures = [String: String]()
        
        // Loop through a fixed range (e.g., 1 to 20) to get ingredients and measurements
        for index in 1...20 {
            // Retrieve the ingredient and measurement for the given index from the meal detail
            if let ingredient = getIngredientAndMeasurements(for: index, from: mealDetail, propertyname: .Ingredient),
               let measure = getIngredientAndMeasurements(for: index, from: mealDetail, propertyname: .Measurement) {
                // If both ingredient and measurement are available, we add them to the dictionary
                ingredientsWithMeasures[ingredient] = measure
            }
        }
        // Update the ingredientsWithMeasures property with the created dictionary
        self.ingredientsWithMeasures = ingredientsWithMeasures
    }
    
    // Function to get ingredient or measurement for the given index from the meal detail using reflection
    private func getIngredientAndMeasurements(for index: Int, from mealDetail: MealDetail, propertyname: PropertyName) -> String? {
        // Use Mirror to reflect on the properties of mealDetail
        let mirror = Mirror(reflecting: mealDetail)
        // Get the property name based on the index and type (ingredient or measurement)
        let propertyName = getPropertyname(for: index, propertyName: propertyname)
        // Iterate over the children of the mirror to find the property with the matching name
        for child in mirror.children {
            if child.label == propertyName,
               let value = child.value as? String,
               !value.trimmingCharacters(in: .whitespaces).isEmpty {
                // Return the property value if found and it's non-empty
                return value
            }
        }
        // Return nil if the property is not found or is empty
        return nil
    }
    
    // Function to construct the property name string based on the index and type
    private func getPropertyname(for index: Int, propertyName: PropertyName) -> String {
        var propertyNameToReturn: String {
            switch propertyName {
            case .Ingredient:
                // Construct the property name for an ingredient (e.g., "strIngredient1")
                return "\(PropertyNameConstants.strIngredient.rawValue)\(index)"
            case .Measurement:
                // Construct the property name for a measurement (e.g., "strMeasure1")
                return "\(PropertyNameConstants.strMeasure.rawValue)\(index)"
            }
        }
        return propertyNameToReturn
    }
}
