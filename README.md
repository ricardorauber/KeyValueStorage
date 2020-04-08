# KeyValueStorage - A key-value storage module for Swift projects

[![Build Status](https://travis-ci.com/ricardorauber/KeyValueStorage.svg?branch=master)](http://travis-ci.com/)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/KeyValueStorage.svg?style=flat)](http://cocoadocs.org/docsets/KeyValueStorage)
[![License](https://img.shields.io/cocoapods/l/KeyValueStorage.svg?style=flat)](http://cocoadocs.org/docsets/KeyValueStorage)
[![Platform](https://img.shields.io/cocoapods/p/KeyValueStorage.svg?style=flat)](http://cocoadocs.org/docsets/KeyValueStorage)

This module is a simple wrapper for key-value storage frameworks like:

- Keychain
- User Defaults
- Memory (Dictionary)

It is very easy to use, like the Keychain, for instance:

```Swift
import KeyValueStorage
let storage: KeyValueStorage = KeychainKeyValueStorage()
storage.set(string: "something awesome!", for: "secretKey")
print(storage.getString(for: "secretKey")
```

Nice, right? What about the others? Well, all of them implements the `KeyValueStorage` protocol, so it is easy to change as you need:

```Swift
let keychain: KeyValueStorage = KeychainKeyValueStorage()
let userDefaults: KeyValueStorage = UserDefaultsKeyValueStorage()
let memory: KeyValueStorage = MemoryKeyValueStorage()
```

## Why?

You might be asking why another framework for this kind of feature? It's because all the storage frameworks are together? No, not only for that. Actually, this framework has a bigger purpose, it is completely based on the `KeyValueStorage` protocol which provides testability for your app. The way to do it is using the protocol on parameters and properties so you could inject dependencies for different behaviours. For instance, the app could use Keychain while the tests could use Memory, but in the end, the "Storage" object will not mind which one it will be using at runtime.

## Setup

#### CocoaPods

If you are using CocoaPods, add this to your Podfile and run `pod install`.

```Ruby
target 'Your target name' do
    pod 'KeyValueStorage', '~> 1.0'
end
```

## Usage

Add `import KeyValueStorage` to your source code

#### Data values

```Swift
storage.set(data: dataValue, for: "my key")
let value = storage.getData(for: "my key")
```

#### String values

```Swift
storage.set(string: stringValue, for: "my key")
let value = storage.getString(for: "my key")
```

#### Int values

```Swift
storage.set(int: intValue, for: "my key")
let value = storage.getInt(for: "my key")
```

#### Double values

```Swift
storage.set(double: doubleValue, for: "my key")
let value = storage.getDouble(for: "my key")
```

#### Bool values

```Swift
storage.set(bool: boolValue, for: "my key")
let value = storage.getBool(for: "my key")
```

#### Removing keys from the storage

```Swift
storage.remove(key: "my key") // Remove a single key
storage.clear() // Remove all keys
```

## StorageKey

There is also a special object called `StorageKey`. As you can see, it is very simple:

```Swift
struct StorageKey: RawRepresentable, Equatable, Hashable {
	typealias RawValue = String
	let rawValue: String
	init(rawValue: String) {
		self.rawValue = rawValue
	}
}
```

So, why we have created it? Simple, we can use it to set and get keys without using hardcoded strings everywhere. You just need to add a static property in an extension of the `StorageKey` and then use it with autocomplete:

```Swift
extension StorageKey {
	static let key = StorageKey(rawValue: "key")
}

storage.set(string: stringValue, for: .key)
let value = storage.getString(for: .key)
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
