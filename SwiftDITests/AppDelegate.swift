//
//  AppDelegate.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

}

extension Dependency {
    @objc class func initialize() {
        // Register the UsersListProviderType singleton
        Dependency.register(instance: HardCodedUsersProvider() as UsersListProviderType)
        // Register the FriendsProviderTypes, one generic (1) and one specific (2) for a specific user (me)
        // 1) associate with nil tag so it resolves with everything, but use the tag when invoking the factory to build tailored instances
        Dependency.register() { DummyFriendsProvider(user: $0 ?? "Jane Doe") as FriendsProviderType }
        // 2) associate with a specific tag so it uses this specific factory when resolving against this specific tag (but we don't need the tag in the closure body)
        Dependency.register("AliSoftware") { PlistFriendsProvider(plist: "myfriends") as FriendsProviderType }
    }
}
