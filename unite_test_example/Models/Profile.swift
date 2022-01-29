//
//  Person.swift
//  unite_test_example
//
//  Created by Angel Contreras on 1/27/22.
//

import Foundation

struct Profile: Codable {
    let name: String
    let profileName: String
    let badges: [Badge]
    
    enum CodingKeys: String, CodingKey {
        case name, badges
        case profileName = "profile_name"
    }
}
