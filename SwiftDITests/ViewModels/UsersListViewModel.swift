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
        let nyVM = AddressViewModel(city: "New York", country: "USA")
        let cpVM = AddressViewModel(city: "Copenhagen", country: "Denmark")
        UserViewModel.me() { me in
            let allUsers = [
                UserViewModel(name: "John Doe", address: nyVM),
                UserViewModel(name: "Bob", address: nyVM),
                UserViewModel(name: "Alice", address: cpVM),
                me
            ]
            completion(UsersListViewModel(users: allUsers))
        }
    }
    
    static func friends(userID: Int, completion: UsersListViewModel -> Void) {
        // TODO: Implement this
        completion(UsersListViewModel(users: []))
    }
}
