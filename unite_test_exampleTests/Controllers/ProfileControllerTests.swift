//
//  ProfileControllerTests.swift
//  unite_test_exampleTests
//
//  Created by Angel Contreras on 1/28/22.
//

import Foundation
import XCTest

class ProfileControllerTests: XCTestCase {
    
    
    func test_SuccessfulResponse() {
        let dataResponse = getContentOfResourceName("response", type: "json")!
        
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, dataResponse)
            
        }
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        let controller = ProfileController(session: session)
        
        
        var profile: Profile?
        let expect = XCTestExpectation(description: "testing Profile Controller")
        controller.fetchProfileWithURL("http://fakeurl.com") {
            profile = $0
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 15)
        
        XCTAssertNotNil(profile)
    }
    
    func test_EmptyDataReceived() {
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
            
        }
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        let controller = ProfileController(session: session)
        
        
        var profile: Profile?
        let expect = XCTestExpectation(description: "testing Profile Controller")
        controller.fetchProfileWithURL("http://fakeurl.com") {
            profile = $0
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 15)
        
        XCTAssertNil(profile)
    }
    
    // MARK: - Helper Methods
    private func getContentOfResourceName(_ name: String, type: String) -> Data? {
        do {
            guard let path = Bundle(for: ProfileControllerTests.self).path(forResource: name, ofType: type) else {
                XCTFail("File \(name).\(type) was not found.")
                return nil
            }
            
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            XCTFail("Something went wrong when getting file \(name).\(type)")
        }
    
        return nil
    }
}
