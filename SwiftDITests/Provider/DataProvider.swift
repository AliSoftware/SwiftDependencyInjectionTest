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
            let allDicts = [
                ["name":"John Doe", "city": "New York", "country": "USA"],
                ["name":"Bob", "city": "New York", "country": "USA"],
                ["name":"Alice", "city": "Copenhagen", "country": "Denmark"],
                meDict
            ]
            completion(allDicts)
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
    
    func fetchFriends(user: String, completion: [StringDict] -> Void) {
        let nbFriends = user.characters.count
        let friendsDicts = (1...nbFriends).map { idx in
            ["name": "\(user)'s friend #\(idx)","city": "\(user)Ville","country": "FriendsLand"]
        }
        completion(friendsDicts)
    }
}
