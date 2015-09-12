//
//  UsersListViewModel.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

struct UsersListViewModel {
    static let dataProvider: DataProviderType = Dependency.resolve()

    var users: [UserViewModel]
    
    static func registeredUsers(completion: UsersListViewModel -> Void) {
        dataProvider.fetchRegisteredUsers() { userDicts in
            let userVMs = userDicts.flatMap(UserViewModel.init)
            completion(UsersListViewModel(users: userVMs))
        }
    }
    
    static func friends(userName: String, completion: UsersListViewModel -> Void) {
        dataProvider.fetchFriends(userName) { userDicts in
            let userVMs = userDicts.flatMap(UserViewModel.init)
            completion(UsersListViewModel(users: userVMs))
        }
    }

}
