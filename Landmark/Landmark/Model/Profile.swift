//
//  Profile.swift
//  Landmark
//
//  Created by Meheretab M on 30/08/2021.
//

import Foundation
struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    static let `default` = Profile(username: "EliasA.")

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"
        var id: String { self.rawValue }
      }
}
