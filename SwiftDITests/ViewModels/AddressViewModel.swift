//
//  AddressViewModel.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

struct AddressViewModel {
    var city: String
    var country: String
    
    var formatted: String {
        return "\(city), \(country)"
    }
}