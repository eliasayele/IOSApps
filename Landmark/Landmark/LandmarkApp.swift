//
//  LandmarkApp.swift
//  Landmark
//
//  Created by Meheretab M on 27/08/2021.
//

import SwiftUI

@main
struct LandmarkApp: App {
    
    @StateObject private var modelData =  ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
