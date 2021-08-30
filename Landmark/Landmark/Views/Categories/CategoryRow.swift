//
//  CategoryRow.swift
//  Landmark
//
//  Created by Meheretab M on 30/08/2021.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [LandMark]
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading,15)
                .padding(.top,5)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
        
                    ForEach(items) { Landmark in
                        NavigationLink(
                            destination: LandmarkDetail(landmark: Landmark))
                        {
                            CategoryItem(landmark: Landmark)
                        }
                    }
                }
            }.frame(height:180)
    }
  }
}

struct CategoryRow_Previews: PreviewProvider {
    static var landmarks  = ModelData().landmarks
    static var previews: some View {
        CategoryRow(
            categoryName: landmarks[0].category.rawValue,
            items: Array(landmarks.prefix(4)))
    }
}
