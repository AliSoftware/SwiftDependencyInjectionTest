# Introduction

This is a test project to play around and explore some Dependency Injection ideas in Swift.

This is open to discussion, remarks and suggestions as it's merely experimental.

# Git Tags & Project evolution

## demo-base

I started with a simple dummy project without any DI: just a simple project using MVVM to put in place the basis that demonstrates the problem and on top of which we would try our DI solutions later.

## sharedInstance

On top of the `demo-base`, I added some commit to introduce a "DataProvider" (which would typically be the intance managing WebService calls in your real-world app) as a `sharedInstance`, to demonstrate the "bad" solution, that is to show how we typically do this stuff when we don't do DI.

The problem with this solution is that the fact that our ViewModel classes use this `DataProvider.sharedInstance` is an implementation detail, and we can't externally change to provide a different instance to be used by our ViewModel for, say, test purposes.

Our experiment will try to use DI, or if not true-DI at least something close to it that will allow use to use different dependencies (like a different DataProvider) for our Unit Tests.

## DependencyContainer

This is the tag where we started introducing the `DependencyContainer` — which I should better have called `DependencyFactory` or `DependencyResolver` to be fair. This is a class that has a `resolve()` method which will return the expected (previously-registered) instance for a given protocol.

So you give it a protocol and ask "hey I want you to resolve it, I need an instance that conforms to this protocol" and it gives you one (that's why I should probably have called it a `DependencyFactory` instead, whoops)

At this stage, this `DependencyContainer` was only able to register instances directly — so it basically could only "return sharedInstances", and didn't let you create new ones each time you `resolve()`

## DependencyResolver

This tag is the next step to the previous one. The newly-renamed `Dependency` class works as follows:

### Register instances and instance factories

At the beginning of your app's life-cycle (or better, in `@objc class func initialize() {}` declared in an `extension Dependency`), you register instances and instance factories with protocols.

* `register(singleton: _)` will register a singleton instance with a given protocol
* `register(instanceFactory: _)` will register an instance factory — which generates a new instance each time you `resolve()`
* You need to pass an instance (or instance factory) that is _casted to the protocol type_ you want to register it with (e.g. `register(singleton: PlistUsersProvider() as UsersListProviderType)` will register the PlistUsersProvider singleton instance so it's used when we request an object conforming to the `UsersListProviderType` protocol)
* if you give a `tag` in the parameter to `register(tag: …, …)`, it will associate that instance or instance factory with this tag while registering

### Resolve dependencies

* `Dependency.resolve()` will return a new instance matching the requested protocol
* Specify the return type of `resolve` (using `var v: MyProtocol = Dependency.resolve()` or `var v = Dependency.resolve() as MyProtocol`) so that Swift's type inference knows which protocol you're trying to resolve into an instance
* If that protocol was registered as a singleton, the same instance will be returned each time you call `resolve()` for this protocol type. Otherwise, the instance factory will generate a new instance each time
* `Dependency.resolve(tag)` will try to find an instance (or instance factory) that match both the requested protocol _and_ the tag. If it doesn't find any, it will fallback to an instance (or instance factory) that only match the requested protocol. That allows you to have generic resolutions for all tags but some, which will use a specific resolution instead.


# Example for the current solution

Somewhere in your App target, register the dependencies. Best place to do that is probably in `Dependency.initialize()` so that it's configured right before the first time we use `Dependency` somewhere in the app.

```swift
extension Dependency {
    @objc class func initialize() {
        Dependency.register(singleton: WebService() as WebServiceType)
        Dependency.register() { DummyFriendsProvider(user: $0 ?? "Jane Doe") as FriendsProviderType }
        Dependency.register("me") { PlistFriendsProvider(plist: "myfriends") as FriendsProviderType }
    }
}
```

Do the same in your Unit Tests target & test cases, but obviously with different Dependencies registered depending on what you want to test and what instances you need to change to provide dummy implementations for your tests.


Then to use dependencies throughout your app, use `Dependency.resolve()`, like:

```swift
struct SomeViewModel {
  let ws: WebServiceType = Dependency.resolve()
  var friendsProvider: FriendsProviderType
  init(userName: String) {
    friendsProvider = Dependency.resolve(userName)
  }
```

In your app target:

* `ws` will be resolved as your singleton instance `WebService` registered before.
* `friendsProvider` will be resolved as a new instance each time, which will be an instance created via `PlistFriendsProvider(plist: "myfriends")` if `userName` is `me` and created via `DummyFriendsProvider(userName)` for any other `userName` value (because `resolve(userName)` will fallback to `resolve(nil)` in that case, using the instance factory which was registered without a tag).
