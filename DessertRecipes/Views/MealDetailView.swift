//
//  MealDetailView.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject var viewModel: MealDetailViewModel
    var title: String
    
    var body: some View {
        ScrollView{
            VStack {
                Group {
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    Text(viewModel.mealDetail?.strInstructions ?? "Loading")
                        .font(.body)
                }
                .padding(.horizontal)
                VStack {
                    Divider()
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.bold)
                    Divider()
                    VStack( alignment: .center, spacing: 20) {
                        VStack(alignment: .center) {
                            ForEach(viewModel.ingredientsWithMeasures.sorted(by: <), id: \.key) { ingredient, measure in
                                HStack {
                                    Text(ingredient)
                                        .padding(.leading)
                                    Spacer()
                                    Text(measure)
                                        .padding(.trailing)
                                }
                                .padding(.horizontal)
                                Divider()
                            }
                        }
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 2)
            )
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .padding()
        .task {
            viewModel.fetchMeals()
        }
    }
}

#Preview {
    MealDetailView(viewModel: MealDetailViewModel(mealID: "53049"), title: "King")
}