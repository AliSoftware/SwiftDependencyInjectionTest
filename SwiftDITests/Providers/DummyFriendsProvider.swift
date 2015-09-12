//
//  DummyFriendsProvider.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 12/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

struct DummyFriendsProvider : FriendsProviderType {
    var user: String
    
    func fetchFriends(completion: [StringDict] -> Void) {
        let nbFriends = user.characters.count
        let friendsDicts = (1...nbFriends).map { idx in
            ["name": "\(user)'s friend #\(idx)","city": "\(user)Ville","country": "FriendsLand"]
        }
        completion(friendsDicts)
    }
}
