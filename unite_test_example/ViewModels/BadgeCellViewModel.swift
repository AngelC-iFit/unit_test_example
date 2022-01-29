//
//  BadgeCellViewModel.swift
//  unite_test_example
//
//  Created by Angel Contreras on 1/28/22.
//

import Foundation

struct BadgeCellViewModel {
    private let badge: Badge
    
    init(_ badge: Badge) {
        self.badge = badge
    }
    
    var title: String? {
        return badge.name
    }
    
    var subtitle: String? {
        let numberOfCourses = badge.courses.count
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let dateString = dateFormatter.string(from: badge.earnedDate)
        let coursesString = numberOfCourses == 1 ? "course" : "courses"
        return "\(numberOfCourses) \(coursesString) • Earned on \(dateString)"
    }
}
