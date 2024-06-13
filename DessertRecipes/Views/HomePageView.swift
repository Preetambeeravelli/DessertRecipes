//
//  HomePageView.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import SwiftUI

struct HomePageView: View {
    // State object to manage the view model for the home page
    @StateObject var homePageViewModel = HomePageViewModel()
    
    var body: some View {
        VStack {
            // List to display meals fetched from the view model
            List {
                // Iterating over the meals from the view model
                ForEach(homePageViewModel.meals) { meal in
                    // Navigation link to navigate to the meal detail view when a meal is selected
                    NavigationLink {
                        // Meal detail view initialized with the selected meal's ID and title
                        MealDetailView(mealDetailViewModel: MealDetailViewModel(mealID: meal.idMeal), title: meal.strMeal)
                    } label: {
                        // Custom view for displaying meal name and image
                        MealListView(mealName: meal.strMeal, mealImage: meal.strMealThumb)
                    }
                    // Hides the row separator
                    .listRowSeparator(.hidden)
                    // Removes default insets for list rows
                    .listRowInsets(EdgeInsets())
                }
            }
            // Adds horizontal padding to the list
            .padding(.horizontal)
            // Sets the list style to plain
            .listStyle(.plain)
            // Hides scroll indicators
            .scrollIndicators(.hidden)
            // Sets the navigation title
            .navigationTitle(AppTextConstants.DessertRecipes.rawValue)
            // Fetch meals when the view appears
            .task {
                //fetch meals when the view appears
                homePageViewModel.fetchMeals()
            }
        }
    }
}

#Preview {
    HomePageView()
}
