//
//  ProfileSummary.swift
//  Landmark
//
//  Created by Meheretab M on 30/08/2021.
//

import SwiftUI

struct ProfileSummary: View {
    @EnvironmentObject var modelData:ModelData
    var profile: Profile
    

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)
              
                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)
               Divider()
                VStack(alignment:.leading){
                    Text("Completed Badges")
                                            .font(.headline)
                    ScrollView(.horizontal){
                        HStack{
                            HikeBadge(name: "First Hike")
                            HikeBadge(name: "Earth day")
                                .hueRotation(Angle(degrees: 90))
                            HikeBadge(name: "Tenth Hike" )
                                .grayscale(/*@START_MENU_TOKEN@*/0.50/*@END_MENU_TOKEN@*/)
                                .hueRotation(Angle(degrees: 45))
                        }
                        .padding(.bottom)
                    }
                    Divider()
                    VStack {
                        Text("Recent Hikes")
                            .font(.headline)
                        HikeView(hike: modelData.hikes[0])
                    }
                }
                
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
            .environmentObject(ModelData())
    }
}
