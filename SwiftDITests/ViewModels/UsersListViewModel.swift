//
//  UsersListViewModel.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

struct UsersListViewModel {
    
    static let usersProvider: UsersListProviderType = Dependency.resolve()

    var users: [UserViewModel]
    
    static func registeredUsers(completion: UsersListViewModel -> Void) {
        usersProvider.fetchRegisteredUsers() { userDicts in
            let userVMs = userDicts.flatMap(UserViewModel.init)
            completion(UsersListViewModel(users: userVMs))
        }
    }
    
    static func friends(userName: String, completion: UsersListViewModel -> Void) {
        let friendsProvider: FriendsProviderType = Dependency.resolve(userName)
        friendsProvider.fetchFriends() { userDicts in
            let userVMs = userDicts.flatMap(UserViewModel.init)
            completion(UsersListViewModel(users: userVMs))
        }
    }

}
