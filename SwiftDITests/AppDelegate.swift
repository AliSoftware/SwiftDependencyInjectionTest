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
        // 1) Register the UsersListProviderType singleton
        Dependency.register(instance: HardCodedUsersProvider() as UsersListProviderType)                               // (1)
        
        // 2) Register the FriendsProviderTypes, one generic (2a) and one specific (2b) for a specific user (me)
        Dependency.register(instanceFactory: { DummyFriendsProvider(user: $0 ?? "Jane Doe") as FriendsProviderType })  // (2a)
        Dependency.register("AliSoftware") { PlistFriendsProvider(plist: "myfriends") as FriendsProviderType }         // (2b)
    }
}

/* Comments

(1): Dependency.register(instance: HardCodedUsersProvider() as UsersListProviderType)

This registers a singleton instance to be associated with the UsersListProviderType protocol.
So each time we try to `resolve() as UsersListProviderType`, it will return that singleton instance.

----

(2a): Dependency.register(instanceFactory: { DummyFriendsProvider(user: $0 ?? "Jane Doe") as FriendsProviderType })

This registers an instance factory to be associated with the FriendsProviderType protocol.
So each time we try to `resolve() as FriendsProviderType`, it will invoke that closure and return a new instance.

This instance factory will also be invoked if we try to `resolve(someTag) as FriendsProviderType`, unless there is a specific
instance factory registered with that specific `someTag` (as we'll do below in (2b) for the "AliSoftware" tag)

Note: we could have used an alternate syntax, using a trailing closure instead:

(2a): Dependency.register() { DummyFriendsProvider(user: $0 ?? "Jane Doe") as FriendsProviderType }

----

(2b): Dependency.register("AliSoftware") { PlistFriendsProvider(plist: "myfriends") as FriendsProviderType }

This registers an instance factory to be associated with a specific tag "AliSoftware" and the FriendsProviderType protocol.
So each time we try to `resolve("AliSoftware") as FriendsProviderType`, it will invoke that specific factory and return a new instance.
-- But each time we try to `resolve("FooBar") as FriendsProviderType`, or use any tag other than AliSoftware, it will fallback to (2a)

Note: we could have used an alternate syntax, without trailing closure:

(2b): Dependency.register("AliSoftware", instanceFactory: { PlistFriendsProvider(plist: "myfriends") as FriendsProviderType })

Note: As resolve("AliSoftware") will always generate a `PlistFriendsProvider(plist: "myfriends")` instance, and that
      instance doesn't really need to be created each time, reading from the plist each time we initialize it, maybe we
      should use a singleton instance instead in that use case. This alternate solution would simply be achieved like this:

      Dependency.register("AliSoftware", instance: PlistFriendsProvider(plist: "myfriends") as FriendsProviderType)

*/
