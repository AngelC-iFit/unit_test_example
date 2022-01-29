//
//  Badge.swift
//  unite_test_example
//
//  Created by Angel Contreras on 1/27/22.
//

import Foundation

struct Badge: Codable {
    let id: Int
    let name: String
    let earnedDate: Date
    let courses: [Course]
    
    enum CodingKeys: String, CodingKey {
        case id, name, courses
        case earnedDate = "earned_date"
    }
}
