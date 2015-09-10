// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

protocol StoryboardScene : RawRepresentable {
    static var storyboardName : String { get }
    static func storyboard() -> UIStoryboard
    static func initialViewController() -> UIViewController
    func viewController() -> UIViewController
    static func viewController(identifier: Self) -> UIViewController
}

extension StoryboardScene where Self.RawValue == String {
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }

    static func initialViewController() -> UIViewController {
        return storyboard().instantiateInitialViewController()!
    }

    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewControllerWithIdentifier(self.rawValue)
    }
    static func viewController(identifier: Self) -> UIViewController {
        return identifier.viewController()
    }
}

extension UIStoryboard {
    struct Scene {
        enum Main : String, StoryboardScene {
            static let storyboardName = "Main"

            case UsersList = "UsersList"
            static func usersListViewController() -> UsersListViewController {
                return Main.UsersList.viewController() as! UsersListViewController
            }

            case Profile = "Profile"
            static func profileViewController() -> UserViewController {
                return Main.Profile.viewController() as! UserViewController
            }

            case Map = "Map"
            static func mapViewController() -> AddressViewController {
                return Main.Map.viewController() as! AddressViewController
            }
        }
        enum LaunchScreen {
            static let storyboardName = "LaunchScreen"
        }
    }

    struct Segue {
    }
}

