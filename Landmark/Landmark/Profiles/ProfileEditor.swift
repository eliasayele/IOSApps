//
//  ProfileEditor.swift
//  Landmark
//
//  Created by Meheretab M on 30/08/2021.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile:Profile
    
    //retuning the range of dates
    var dataRange: ClosedRange<Date>{
        let min  = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year,value: -1 ,to: profile.goalDate)!
        
        return min...max
    }
    
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username",text:$profile.username)
            }
            Toggle(isOn: $profile.prefersNotifications)  {
                Text("Enable Notification")
                    .bold()
            }
            VStack(alignment:.leading,spacing:30) {
                Text("Seasonal Photo").bold()
                Picker("Seasonal Photo",selection: $profile.seasonalPhoto){
                    ForEach(Profile.Season.allCases){
                        season in Text(season.rawValue).tag(season)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
            }
            DatePicker(selection: $profile.goalDate, in: dataRange,displayedComponents: .date) {
                Text("Goal Date").bold()
            }
            
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
