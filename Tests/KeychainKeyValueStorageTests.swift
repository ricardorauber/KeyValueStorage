import Quick
import Nimble
import KeychainSwift
@testable import KeyValueStorage

class KeychainKeyValueStorageTests: QuickSpec {
	override func spec() {
		
		var storage: KeychainKeyValueStorage?
		
		describe("KeychainKeyValueStorage") {
			
			context("initialization") {
				
				context("with no parameters") {
					
					beforeEach {
						storage = KeychainKeyValueStorage()
						storage?.clear()
					}
					
					it("should not be nil") {
						expect(storage).toNot(beNil())
					}
					
					it("should have an instance of the KeychainSwift") {
						expect(storage?.storage).to(beAnInstanceOf(KeychainSwift.self))
					}
				}
				
				context("with a nil parameter") {
					
					beforeEach {
						storage = KeychainKeyValueStorage(storage: nil)
						storage?.clear()
					}
					
					it("should not be nil") {
						expect(storage).toNot(beNil())
					}
					
					it("should have an instance of the KeychainSwift") {
						expect(storage?.storage).to(beAnInstanceOf(KeychainSwift.self))
					}
				}
				
				context("with a valid parameter") {
					
					var keychain: KeychainSwift?
					
					beforeEach {
						keychain = KeychainSwift()
						storage = KeychainKeyValueStorage(storage: keychain)
						storage?.clear()
					}
					
					it("should not be nil") {
						expect(storage).toNot(beNil())
					}
					
					it("should have the standard KeychainSwift") {
						expect(storage?.storage).to(beIdenticalTo(keychain))
					}
				}
			}
			
			context("manage") {
				
				beforeEach {
					storage = KeychainKeyValueStorage()
					storage?.clear()
				}
				
				context("String") {
					
					it("should return nil for an invalid key") {
						let value = storage?.getString(for: .invalid)
						expect(value).to(beNil())
					}
					
					it("should return the value for a valid key") {
						storage?.set(string: "test", for: .key)
						let value = storage?.getString(for: "key")
						expect(value).to(be("test"))
					}
				}
				
				context("Int") {
					
					it("should return nil for an invalid key") {
						let value = storage?.getInt(for: .invalid)
						expect(value).to(beNil())
					}
					
					it("should return the value for a valid key") {
						storage?.set(int: 10, for: .key)
						let value = storage?.getInt(for: "key")
						expect(value).to(be(10))
					}
				}
				
				context("Double") {
					
					it("should return nil for an invalid key") {
						let value = storage?.getDouble(for: .invalid)
						expect(value).to(beNil())
					}
					
					it("should return the value for a valid key") {
						storage?.set(double: 10.5, for: .key)
						let value = storage?.getDouble(for: "key")
						expect(value).to(beCloseTo(10.5))
					}
				}
				
				context("Bool") {
					
					it("should return nil for an invalid key") {
						let value = storage?.getBool(for: .invalid)
						expect(value).to(beNil())
					}
					
					it("should return the value for a valid key") {
						storage?.set(bool: true, for: .key)
						let value = storage?.getBool(for: "key")
						expect(value).to(beTrue())
					}
				}
				
				context("Remove") {
					
					it("should remove a stored key") {
						storage?.set(int: 1, for: "key1")
						storage?.set(int: 2, for: .key2)
						storage?.remove(key: .key1)
						let value1 = storage?.getInt(for: .key1)
						let value2 = storage?.getInt(for: "key2")
						expect(value1).to(beNil())
						expect(value2).to(be(2))
					}
				}
				
				context("Clear") {
					
					it("should remove all stored keys") {
						storage?.set(int: 1, for: .key1)
						storage?.set(int: 2, for: "key2")
						storage?.clear()
						let value1 = storage?.getInt(for: "key1")
						let value2 = storage?.getInt(for: .key2)
						expect(value1).to(beNil())
						expect(value2).to(beNil())
					}
				}
			}
		}
	}
}

// MARK: - Private helpers

private extension StorageKey {
	
	static let invalid = StorageKey(rawValue: "invalid")
	static let key = StorageKey(rawValue: "key")
	static let key1 = StorageKey(rawValue: "key1")
	static let key2 = StorageKey(rawValue: "key2")
}
