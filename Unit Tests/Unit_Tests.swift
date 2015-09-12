//
//  Unit_Tests.swift
//  Unit Tests
//
//  Created by Olivier Halligon on 11/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import XCTest

class TestUsersProvider : UsersListProviderType {
    func getAuthToken(completion: Bool -> Void) {
        completion(false)
    }
    func fetchRegisteredUsers(completion: [StringDict] -> Void) {
        completion([])
    }
    func fetchMyProfile(completion: StringDict? -> Void) {
        completion(["name": "nameMe", "city": "cityMe", "country": "countryMe"])
    }
}

class Unit_Tests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Dependency.register(singleton: TestUsersProvider() as UsersListProviderType)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserViewModelMe() {
        let exp = self.expectationWithDescription("DataProvider request completed")
        
        UserViewModel.me { meVM in
            XCTAssertNotNil(meVM)
            XCTAssertEqual(meVM!.name, "nameMe")
            XCTAssertEqual(meVM!.address.city, "cityMe")
            XCTAssertEqual(meVM!.address.country, "countryMe")
            
            exp.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(0.5, handler: nil)
    }
    
}
