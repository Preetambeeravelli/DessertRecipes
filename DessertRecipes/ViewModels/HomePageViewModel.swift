//
//  HomePageViewModel.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation
import Combine

class HomePageViewModel: ObservableObject{
    @Published var meals: [Meals] = []
    @Published var errorMessage: String?
    
    private let networkManager = NetworkManager<MealsModel>(requestType: .Category("Dessert"))
    private var cancellables: Set<AnyCancellable> = []
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
               }, receiveValue: { [weak self] meals in
                   self?.meals = meals.meals.compactMap{$0}.sorted()
               })
               .store(in: &cancellables)
       }
}
