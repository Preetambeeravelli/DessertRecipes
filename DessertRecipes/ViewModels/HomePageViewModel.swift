//
//  HomePageViewModel.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import Foundation
import Combine

class HomePageViewModel: ObservableObject{
    //Published property to store meals we get from the network request
    @Published var meals: [Meals] = []
    // Published property to store any error message
    @Published var errorMessage: String?
    //Creating a network manager object to make request
    private let networkManager = NetworkManager<MealsModel>(requestType: .Category(MealCategories.Dessert.rawValue))
    //Set to hold cancellable references
    private var cancellables: Set<AnyCancellable> = []
    
    //Function called from view to fetch the meals
    func fetchMeals() {
        //making the network request using the netowrkManager object
        networkManager.makeRequest()
            //receiving the result on main thread
               .receive(on: DispatchQueue.main)
               .sink(receiveCompletion: { [weak self] completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       //updating error if we have any
                       self?.errorMessage = "\(error)"
                   }
               }, receiveValue: { [weak self] meals in
                   //Updating the meals once we receive, sorting and discarding any nill values
                   self?.meals = meals.meals.compactMap{$0}.sorted()
               })
            //Storing the subscriptions in the set
               .store(in: &cancellables)
       }
}
