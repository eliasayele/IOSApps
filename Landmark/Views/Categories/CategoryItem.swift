//
//  CategoryItem.swift
//  Landmark
//
//  Created by Meheretab M on 30/08/2021.
//

import SwiftUI

struct CategoryItem: View {
    var landmark:LandMark
    var body: some View {
        VStack(alignment:.leading) {
            landmark.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 165, height: 165)
                .cornerRadius(5)
            Text(landmark.name)
                .foregroundColor(.primary)
                .font(.caption)
            
        }
        .padding(.leading,15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(landmark: ModelData().landmarks[0])
    }
}
