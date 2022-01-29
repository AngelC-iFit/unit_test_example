//
//  BadgeCellViewModelTets.swift
//  unite_test_exampleTests
//
//  Created by Angel Contreras on 1/28/22.
//

import Foundation
@testable import unite_test_example
import XCTest

class BadgecellViewModelTests: XCTestCase {
    
    func test_TitleText() {
        let expectedTitleText = "Juan"
        let badge = Badge(id: 0, name: expectedTitleText, earnedDate: Date(), courses: [])
        let vm = BadgeCellViewModel(badge)
        
        XCTAssertEqual(vm.title, expectedTitleText)
    }
    
    func test_SubtitleText() {
        let expectedSubtitle = "1 course • Earned on December 31, 1969"
        let date = Date(timeIntervalSince1970: 1000)
        let badge = Badge(id: 0, name: "", earnedDate: date, courses: [Course(title: "")])
        let vm = BadgeCellViewModel(badge)
        XCTAssertEqual(vm.subtitle, expectedSubtitle)
    }
    
    func test_multipleCoursesSubtitleText() {
        let date = Date(timeIntervalSince1970: 1000)
        let badge = Badge(id: 0, name: "", earnedDate: date, courses: [Course(title: ""), Course(title: "")])
        let vm = BadgeCellViewModel(badge)
        XCTAssertTrue(vm.subtitle?.contains("courses") == true)
    }
}
