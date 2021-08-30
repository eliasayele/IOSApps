//
//  LandmarkRow.swift
//  Landmark
//
//  Created by Meheretab M on 27/08/2021.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: LandMark
    var body: some View {
        HStack {
            landmark.image .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var landmarks = ModelData().landmarks
    static var previews: some View {
        Group {
             
            LandmarkRow(landmark: landmarks[0]) 
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}

