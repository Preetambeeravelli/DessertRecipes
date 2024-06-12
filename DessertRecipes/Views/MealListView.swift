//
//  MealListView.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import SwiftUI

struct MealListView: View {
    var mealName: String
    var mealImage: String
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .frame(height: 100, alignment: .center)
                .overlay {
                    HStack{
                        Text("\(mealName)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .minimumScaleFactor(0.6)
                        Spacer()
                        AsyncImage(url: URL(string: mealImage)) { returnedImage in
                            returnedImage
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 70, height: 70)
                        .padding(.trailing)
                    }
                }
        }
        .padding()
    }
}

#Preview {
    MealListView(mealName: "Apple Frangipan Tart", mealImage: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")
}
