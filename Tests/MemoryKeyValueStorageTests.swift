import Quick
import Nimble
@testable import KeyValueStorage

class MemoryKeyValueStorageTests: QuickSpec {
	override func spec() {
		
		var storage: MemoryKeyValueStorage!
		
		describe("MemoryKeyValueStorage") {
			
			context("initialization") {
				
				context("with no parameters") {
					
					beforeEach {
						storage = MemoryKeyValueStorage()
						storage.clear()
					}
					
					it("should have an empty dictionary") {
						expect(storage.storage).to(be([:]))
					}
				}
			}
			
			context("manage") {
				
				beforeEach {
					storage = MemoryKeyValueStorage()
					storage.clear()
				}
				
				context("Data") {
					
					it("should return nil for an invalid key") {
						let value = storage.getData(for: .invalid)
						expect(value).to(beNil())
					}
					
					it("should return the value for a valid key") {
						let data = "test".data(using: .utf8)!
						storage.set(data: data, for: .key)
						let value = storage.getData(for: "key")
						expect(value) == data
					}
				}
				
				context("String") {
					
					it("should return nil for an invalid key") {
						let value = storage.getString(for: .invalid)
						expect(value).to(beNil())
					}
					
					it("should return the value for a valid key") {
						storage.set(string: "test", for: .key)
						let value = storage.getString(for: "key")
						expect(value).to(be("test"))
					}
				}
				
				context("Int") {
					
					it("should return nil for an invalid key") {
						let value = storage.getInt(for: .invalid)
						expect(value).to(beNil())
					}
					
					it("should return the value for a valid key") {
						storage.set(int: 10, for: .key)
						let value = storage.getInt(for: "key")
						expect(value).to(be(10))
					}
				}
				
				context("Double") {
					
					it("should return nil for an invalid key") {
						let value = storage.getDouble(for: .invalid)
						expect(value).to(beNil())
					}
					
					it("should return the value for a valid key") {
						storage.set(double: 10.5, for: .key)
						let value = storage.getDouble(for: "key")
						expect(value).to(beCloseTo(10.5))
					}
				}
				
				context("Bool") {
					
					it("should return nil for an invalid key") {
						let value = storage.getBool(for: .invalid)
						expect(value).to(beNil())
					}
					
					it("should return the value for a valid key") {
						storage.set(bool: true, for: .key)
						let value = storage.getBool(for: "key")
						expect(value).to(beTrue())
					}
				}
				
				context("Remove") {
					
					it("should remove a stored key") {
						storage.set(int: 1, for: "key1")
						storage.set(int: 2, for: .key2)
						storage.remove(key: .key1)
						let value1 = storage.getInt(for: .key1)
						let value2 = storage.getInt(for: "key2")
						expect(value1).to(beNil())
						expect(value2).to(be(2))
					}
				}
				
				context("Clear") {
					
					it("should remove all stored keys") {
						storage.set(int: 1, for: .key1)
						storage.set(int: 2, for: "key2")
						storage.clear()
						let value1 = storage.getInt(for: "key1")
						let value2 = storage.getInt(for: .key2)
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
