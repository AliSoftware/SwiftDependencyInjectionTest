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
    
    static func me(completion: UserViewModel? -> Void) {
        let dataProvider: DataProviderType = DependencyContainer.resolve()
        dataProvider.fetchMyProfile() { userDict in
            completion(userDict.flatMap(UserViewModel.init))
        }
    }
    
    init(name: String, address: AddressViewModel) {
        self.name = name
        self.address = address
    }
    
    init?(dictionary userDict: [String:String]) {
        guard let name = userDict["name"],
            let city = userDict["city"],
            let country = userDict["country"]
            else { return nil }
        self.name = name
        self.address = AddressViewModel(city: city, country: country)
    }
}