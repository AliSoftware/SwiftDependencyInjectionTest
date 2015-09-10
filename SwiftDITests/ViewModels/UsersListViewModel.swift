//
//  UsersListViewModel.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

struct UsersListViewModel {
    var users: [UserViewModel]
    
    static func registeredUsers(completion: UsersListViewModel -> Void) {
        DataProvider.sharedInstance.fetchRegisteredUsers() { userDicts in
            let userVMs = userDicts.map(UserViewModel.init).flatMap({$0})
            completion(UsersListViewModel(users: userVMs))
        }
    }
    
    static func friends(userID: Int, completion: UsersListViewModel -> Void) {
        // TODO: Implement this
        completion(UsersListViewModel(users: []))
    }
    

}
