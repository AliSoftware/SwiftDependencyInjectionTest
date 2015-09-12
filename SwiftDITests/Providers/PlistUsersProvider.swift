//
//  PlistUsersProvider.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 11/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

class PlistUsersProvider : UsersListProviderType {
    var token: String?
    
    let plistData: NSDictionary = {
        guard let path = NSBundle.mainBundle().pathForResource("users", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path)
            else { return NSDictionary() }
        return dict
    }()
    
    func getAuthToken(completion: Bool -> Void) {
        token = plistData["token"] as? String
        completion(true)
    }
    
    func fetchRegisteredUsers(completion: [StringDict] -> Void) {
        guard token != nil else { completion([]); return }
        fetchMyProfile { meDict in
            var allDicts = self.plistData["registeredUsers"] as! [StringDict]
            if let meDict = meDict {
                allDicts.append(meDict)
            }
            completion(allDicts)
        }
    }
    
    func fetchMyProfile(completion: StringDict? -> Void) {
        guard token != nil else { completion(nil); return }
        let dict = plistData["me"] as! StringDict
        completion(dict)
    }
}
