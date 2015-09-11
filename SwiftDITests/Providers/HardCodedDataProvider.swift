//
//  HardCodedDataProvider.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 11/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

class HardCodedDataProvider : DataProviderType {
    var token: String?
    
    func getAuthToken(completion: Bool -> Void) {
        token = "FakeToken"
        completion(true)
    }
    
    func fetchRegisteredUsers(completion: [StringDict] -> Void) {
        guard token != nil else { completion([]); return }
        fetchMyProfile { meDict in
            var allDicts = [
                ["name":"John Doe", "city": "New York", "country": "USA"],
                ["name":"Bob", "city": "New York", "country": "USA"],
                ["name":"Alice", "city": "Copenhagen", "country": "Denmark"],
            ]
            if let meDict = meDict {
                allDicts.append(meDict)
            }
            completion(allDicts)
        }
    }
    
    func fetchMyProfile(completion: StringDict? -> Void) {
        guard token != nil else { completion(nil); return }
        let dict = [
            "name": "AliSoftware",
            "city": "Rennes",
            "country": "France"
        ]
        completion(dict)
    }
    
    func fetchFriends(user: String, completion: [StringDict] -> Void) {
        guard token != nil else { completion([]); return }
        let nbFriends = user.characters.count
        let friendsDicts = (1...nbFriends).map { idx in
            ["name": "\(user)'s friend #\(idx)","city": "\(user)Ville","country": "FriendsLand"]
        }
        completion(friendsDicts)
    }
}
