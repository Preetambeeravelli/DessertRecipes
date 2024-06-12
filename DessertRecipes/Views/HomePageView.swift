//
//  HomePageView.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var homePageVM = HomePageViewModel()
    var body: some View {
        VStack{
            NavigationStack{
                List{
                    ForEach(homePageVM.meals){meal in
                        NavigationLink{
                            MealDetailView(viewModel: MealDetailViewModel(mealID: meal.idMeal), title: meal.strMeal)
                        } label: {
                            MealListView(mealName: meal.strMeal, mealImage: meal.strMealThumb)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .navigationTitle(AppTextConstants.DessertRecipes.rawValue)
            }.task {
                homePageVM.fetchMeals()
            }
        }.padding(.horizontal)
    }
}

#Preview {
    HomePageView()
}
