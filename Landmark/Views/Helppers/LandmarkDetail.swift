//
//  LandmarkDetail.swift
//  Landmark
//
//  Created by Meheretab M on 27/08/2021.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData:ModelData
    
    var landmark: LandMark
    var landmarkIndex: Int{
       modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
       // modelData.landmarks.firstIndex(of:landmark.id )!
    }
    var body: some View {
        ScrollView {
            
            MapView(coordinate: landmark.locationCoordinate).frame(height:300).ignoresSafeArea(edges: .top)
            CircleImage(image:landmark.image)
                .offset(y:-130)
                .padding(.bottom, -130)
            VStack(alignment: .leading) {
                HStack {
                  Text(landmark.name)
                        .font(.title)
                         .foregroundColor(.primary)
                  FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
               }
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                        
                }.font(.subheadline)
                .foregroundColor(.secondary)
                    
                Divider()

                Text(landmark.name)
                        .font(.title2)
                Text(landmark.description)
                   
            }
            .padding()
           // Spacer()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        LandmarkDetail(landmark: modelData.landmarks[0])
            .environmentObject(modelData)
    }
}
