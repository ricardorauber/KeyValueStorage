import Quick
import Nimble
@testable import KeyValueStorage

class StorageKeyTests: QuickSpec {
	override func spec() {
		
		describe("StorageKey") {
			
			context("equality") {
				
				it("same keys should be true") {
					let key1: StorageKey = .key1
					let key2: StorageKey = .key1
					expect(key1 == key2).to(beTrue())
				}
				
				it("different keys should be false") {
					let key1: StorageKey = .key1
					let key2: StorageKey = .key2
					expect(key1 == key2).to(beFalse())
				}
			}
			
			context("difference") {
				
				it("same keys should be false") {
					let key1: StorageKey = .key1
					let key2: StorageKey = .key1
					expect(key1 != key2).to(beFalse())
				}
				
				it("different keys should be true") {
					let key1: StorageKey = .key1
					let key2: StorageKey = .key2
					expect(key1 != key2).to(beTrue())
				}
			}
		}
	}
}

// MARK: - Private helpers

private extension StorageKey {

	static let key1 = StorageKey(rawValue: "key1")
	static let key2 = StorageKey(rawValue: "key2")
}
