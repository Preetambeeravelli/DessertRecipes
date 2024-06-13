//
//  MealDetailView.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import SwiftUI

struct MealDetailView: View {
    // State object to manage the view model for the meal detail
    @StateObject var mealDetailViewModel: MealDetailViewModel
    // Title of the meal detail view
    var title: String
    
    var body: some View {
        // ScrollView to enable scrolling if content exceeds the screen size
        ScrollView {
            // VStack to arrange content vertically
            VStack {
                // Group containing instructions section
                Group {
                    // Title for instructions section
                    Text(AppTextConstants.Instructions.rawValue)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    // Displaying meal instructions or loading text if instructions are not yet loaded
                    Text(mealDetailViewModel.mealDetail?.strInstructions ?? AppConstants.Loading.rawValue)
                        .font(.body)
                }
                .padding(.horizontal)
                
                // Divider to separate instructions and ingredients sections
                Divider()
                
                // VStack containing ingredients section
                VStack {
                    // Title for ingredients section.
                    Text(AppTextConstants.Ingredients.rawValue)
                        .font(.title2)
                        .fontWeight(.bold)
                    // Divider to separate title and ingredients list
                    Divider()
                    
                    // VStack to display ingredients with their measures
                    VStack(alignment: .center, spacing: 20) {
                        // VStack for each ingredient-measure pair
                        VStack(alignment: .center) {
                            // Iterating over ingredientsWithMeasures dictionary and displaying each pair
                            ForEach(Array(mealDetailViewModel.ingredientsWithMeasures), id: \.key) { ingredient, measure in
                                // HStack to display ingredient name and its measure
                                HStack {
                                    Text(ingredient)
                                        .padding(.leading)
                                    Spacer()
                                    Text(measure)
                                        .padding(.trailing)
                                }
                                .padding(.horizontal)
                                // Divider to separate each ingredient-measure pair
                                Divider()
                            }
                        }
                    }
                }
            }
            // Background with rounded rectangle border
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 2)
            )
        }
        // Sets the navigation title based on the meal's title
        .navigationTitle(title)
        // Displays the navigation bar title in inline mode
        .navigationBarTitleDisplayMode(.inline)
        // Hides scroll indicators
        .scrollIndicators(.hidden)
        // Adds padding around the content
        .padding()
        // Fetches meal details when the view appears
        .task {
            //fetch meals when the view appears
            mealDetailViewModel.fetchMealDetail()
        }
    }
}


#Preview {
    MealDetailView(mealDetailViewModel: MealDetailViewModel(mealID: "52768"), title: "Apple Frangipan Tart")
}
