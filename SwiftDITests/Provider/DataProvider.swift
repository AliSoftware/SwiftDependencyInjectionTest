//
//  DataProvider.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

typealias StringDict = [String:String]

class DataProvider {
    static let sharedInstance = DataProvider() // Boooo!
    
    func fetchRegisteredUsers(completion: [StringDict] -> Void) {
        fetchMyProfile { meDict in
            let allDict = [
                ["name":"John Doe", "city": "New York", "country": "USA"],
                ["name":"Bob", "city": "New York", "country": "USA"],
                ["name":"Alice", "city": "Copenhagen", "country": "Denmark"],
                meDict
            ]
            completion(allDict)
        }
    }
    
    func fetchMyProfile(completion: StringDict -> Void) {
        let dict = [
            "name": "AliSoftware",
            "city": "Rennes",
            "country": "France"
        ]
        completion(dict)
    }
}
