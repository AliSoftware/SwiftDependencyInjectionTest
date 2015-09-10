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
    
    static func registeredUsers() -> UsersListViewModel {
        let nyVM = AddressViewModel(city: "New York", country: "USA")
        let cpVM = AddressViewModel(city: "Copenhagen", country: "Denmark")
        return UsersListViewModel(users: [
            UserViewModel(name: "John Doe", address: nyVM),
            UserViewModel(name: "Bob", address: nyVM),
            UserViewModel(name: "Alice", address: cpVM),
            UserViewModel.me()
        ])
    }
    
    static func friends(userID: Int) -> UsersListViewModel {
        // TODO: Implement this
        return UsersListViewModel(users: [])
    }
}
