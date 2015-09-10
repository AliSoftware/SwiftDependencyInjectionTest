//
//  UserViewModel.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

struct UserViewModel {
    var name: String
    var address: AddressViewModel
    
    static func me(completion: UserViewModel -> Void) {
        completion(UserViewModel(
            name: "AliSoftware",
            address: AddressViewModel(city: "Rennes", country: "France")
        ))
    }
}