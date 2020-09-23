# KeyValueStorage - A key-value storage module for Swift projects

[![Build Status](https://travis-ci.com/ricardorauber/KeyValueStorage.svg?branch=master)](http://travis-ci.com/)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/KeyValueStorage.svg?style=flat)](http://cocoadocs.org/docsets/KeyValueStorage)
[![License](https://img.shields.io/cocoapods/l/KeyValueStorage.svg?style=flat)](http://cocoadocs.org/docsets/KeyValueStorage)
[![Platform](https://img.shields.io/cocoapods/p/KeyValueStorage.svg?style=flat)](http://cocoadocs.org/docsets/KeyValueStorage)

This module is an ultra-light wrapper for key-value storage frameworks like:

- Keychain
- User Defaults
- Memory (Dictionary)

It is very easy to use, like the Keychain, for instance:

```Swift
import KeyValueStorage
let myKey = KeyValueStorageKey(type: .keychain, value: "myKey")
let storage: KeyValueStorageProtocol = KeyValueStorage()
storage.set(value: "something awesome!", for: myKey)
let value: String? = storage.get(key: myKey)
print(value)
```

Nice, right? What about the others? Well, you can easily create a key for any of the storage types:

```Swift
let keychainKey = KeyValueStorageKey(type: .keychain, value: "myKey")
let defaultsKey = KeyValueStorageKey(type: .defaults, value: "myKey")
let memoryKey = KeyValueStorageKey(type: .memory, value: "myKey")
```

## Why?

You might be asking why another framework for this kind of feature? It's because all the storage frameworks are together? No, not only for that. Actually, this framework has a bigger purpose, it is completely based on the `KeyValueStorageProtocol` which provides testability for your app. The way to do it is using the protocol on parameters and properties so you could inject dependencies for different behaviours. You can use the one in the package or implement a mock to avoid some issues on the tests, for instance.

## Setup

#### CocoaPods

If you are using CocoaPods, add this to your Podfile and run `pod install`.

```Ruby
target 'Your target name' do
    pod 'KeyValueStorage', '~> 2.0'
end
```

#### Manual Installation

If you want to add it manually to your project, without a package manager, just copy all files from the `Classes` folder to your project.

## Usage

Add `import KeyValueStorage` to your source code.

#### Store values

The `KeyValueStorageProtocol` supports any kind of `Codable` values, so you can use them as you want to store data into any of the storage types: 

```Swift
storage.set(value: 10, for: myKey)
let intValue: Int? = storage.get(key: myKey)

storage.set(value: "abc", for: myKey)
let stringValue: String? = storage.get(key: myKey)
```

#### Removing keys from the storage

```Swift
storage.remove(key: myKey) // Removes a single key
storage.clean(type: .memory) // Removes all keys from the given storage type
storage.cleanAll() // Removes all keys from all storage types
```

## KeyValueStorageKey

To create keys, we use this special object called `KeyValueStorageKey`. As you can see, it is very simple:

```Swift
public struct KeyValueStorageKey: Equatable, Hashable {
    
    // MARK: - Properties
    
    public let type: KeyValueStorageType
    public let value: String
    
    // MARK: - Initialization
    
    public init(type: KeyValueStorageType, value: String) {
        self.type = type
        self.value = value
    }
}
```

You can extend it with your own keys to use the storage without hardcoded strings everywhere. You just need to add a static property in an extension of the `KeyValueStorageKey` and then use it with autocomplete:

```Swift
extension KeyValueStorageKey {
	static let myKey = KeyValueStorageKey(type: .memory, value: "myKey")
}

storage.set(value: "abcde", for: .myKey)
let value: String? = storage.get(key: .myKey)
```

This is how we can safely reuse keys throughout the app and it is even better in local frameworks because you can create internal extensions for each one.

## Thanks 👍

The creation of this framework was possible thanks to these awesome people:

* Gray Company: [https://www.graycompany.com.br/](https://www.graycompany.com.br/)
* Swift by Sundell: [https://www.swiftbysundell.com/](https://www.swiftbysundell.com/)
* Hacking with Swift: [https://www.hackingwithswift.com/](https://www.hackingwithswift.com/)
* KeychainSwift: [https://github.com/evgenyneu/keychain-swift](https://github.com/evgenyneu/keychain-swift)
* Ricardo Rauber: [http://ricardorauber.com/](http://ricardorauber.com/)

## Feedback is welcome

If you notice any issue, got stuck or just want to chat feel free to create an issue. We will be happy to help you.

## License

KeyValueStorage is released under the [MIT License](LICENSE).
