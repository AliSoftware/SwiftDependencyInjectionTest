//
//  Dependency.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 11/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

class Dependency {
    typealias TagType = String
    typealias InstanceType = Any
    typealias InstanceFactory = Void->InstanceType
    
    struct Key : Hashable {
        var protocolType: Any.Type
        var associatedTag: TagType?
        
        var hashValue: Int {
            return "\(protocolType)-\(associatedTag)".hashValue
        }
    }
    
    static var dependencies = [Key: InstanceFactory]()
    
    static func reset() {
        dependencies.removeAll()
    }
    
    static func register<T : Any>(tag: TagType? = nil, instanceFactory: Void->T) {
        let key = Key(protocolType: T.self, associatedTag: tag)
        dependencies[key] = { instanceFactory($0) }
    }

    static func register<T : Any>(tag: TagType? = nil, @autoclosure(escaping) singleton instanceFactory: Void->T) {
        let key = Key(protocolType: T.self, associatedTag: tag)
        dependencies[key] = {
            let instance = instanceFactory($0)
            dependencies[key] = { return instance }
            return instance
        }
    }

    static func resolve<T>(tag: TagType? = nil) -> T! {
        let key = Key(protocolType: T.self, associatedTag: tag)
        guard let factory = dependencies[key] else {
            fatalError("No instance factory registered with this type and tag")
        }
        return factory() as! T
    }
}

func == (lhs: Dependency.Key, rhs: Dependency.Key) -> Bool {
    return lhs.protocolType == rhs.protocolType && lhs.associatedTag == rhs.associatedTag
}
