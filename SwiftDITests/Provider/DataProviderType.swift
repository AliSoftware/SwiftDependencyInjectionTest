//
//  DataProviderType.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

typealias StringDict = [String:String]

protocol DataProviderType {
    func getAuthToken(completion: Bool -> Void)
    func fetchRegisteredUsers(completion: [StringDict] -> Void)
    func fetchMyProfile(completion: StringDict? -> Void)
    func fetchFriends(user: String, completion: [StringDict] -> Void)
}
