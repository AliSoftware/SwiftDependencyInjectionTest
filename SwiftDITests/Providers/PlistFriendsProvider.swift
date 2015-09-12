//
//  PlistFriendsProvider.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 12/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

class PlistFriendsProvider : FriendsProviderType {
    let friends: [StringDict]
    
    init(plist basename: String) {
        guard let path = NSBundle.mainBundle().pathForResource(basename, ofType: "plist"),
            let list = NSArray(contentsOfFile: path),
            friends = list as? [StringDict]
            else { fatalError("PLIST for \(basename) not found") }
        self.friends = friends
    }
    func fetchFriends(completion: [StringDict] -> Void) {
        completion(friends)
    }
}
