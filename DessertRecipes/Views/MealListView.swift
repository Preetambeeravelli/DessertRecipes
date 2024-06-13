//
//  MealListView.swift
//  DessertRecipes
//
//  Created by Preetam Beeravelli on 6/12/24.
//

import SwiftUI

struct MealListView: View {
    // Name of the meal to display
    var mealName: String
    // URL string for the meal image
    var mealImage: String
    
    var body: some View {
        VStack {
            // RoundedRectangle with border to create a frame for the meal item
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .frame(height: 100, alignment: .center)
                .overlay {
                    // HStack to arrange text and image horizontally
                    HStack {
                        // Text displaying the meal name
                        Text("\(mealName)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .minimumScaleFactor(0.6) // Ensures the text scales down if needed
                        
                        // Spacer to push AsyncImage to the right
                        Spacer()
                        
                        // AsyncImage to load the meal image asynchronously
                        AsyncImage(url: URL(string: mealImage)) { returnedImage in
                            returnedImage
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 15)) // Clip image in a rounded rectangle shape
                                .scaledToFit() // Scales the image to fit the frame
                        } placeholder: {
                            ProgressView() // Placeholder shown while image is loading
                        }
                        .frame(width: 70, height: 70) // Set fixed size for the image
                        .padding(.trailing) // Add trailing padding for layout spacing
                    }
                }
        }
        // Add padding around the RoundedRectangle
        .padding()
    }
}


#Preview {
    MealListView(mealName: "Apple Frangipan Tart", mealImage: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")
}
