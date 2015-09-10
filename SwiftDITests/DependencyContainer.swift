//
//  DependencyContainer.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 11/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

class DependencyContainer {
    static var instancesMappings = [String: Any]()
    
    static func reset() {
        instancesMappings.removeAll()
    }
    
    static func register<T : Any>(instance: T) {
        let key = "\(T.self)"
        instancesMappings[key] = instance
    }
    
    static func resolve<T>() -> T! {
        let key = "\(T.self)"
        let instance = instancesMappings[key] as! T
        return instance
    }
}
