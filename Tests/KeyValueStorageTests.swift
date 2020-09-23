//swiftlint:disable closure_body_length
//swiftlint:disable function_body_length
//swiftlint:disable no_extension_access_modifier
import Nimble
import Quick
@testable import KeyValueStorage

class KeyValueStorageTests: QuickSpec {
    override func spec() {
        
        // MARK: - Properties
        
        var storage: KeyValueStorageProtocol!
        
        // MARK: - Tests
        
        describe("KeyValueStorage") {
            
            beforeEach {
                storage = KeyValueStorage()
                storage.cleanAll()
            }
            
            // MARK: - Memory
            
            context("memory") {
                
                it("should return nil when trying to get a non existent value") {
                    let value: String? = storage.get(key: .memoryString)
                    expect(value).to(beNil())
                }
                
                it("should return nil when trying to get a non existent raw value") {
                    let value = storage.getRaw(key: .memoryString)
                    expect(value).to(beNil())
                }
                
                it("should store a valid value") {
                    let result = storage.set(value: "test", for: .memoryString)
                    expect(result).to(beTrue())
                    let value: String? = storage.get(key: .memoryString)
                    expect(value).toNot(beNil())
                    expect(value).to(equal("test"))
                    let rawValue = storage.getRaw(key: .memoryString)
                    expect(rawValue).toNot(beNil())
                }
                
                it("should remove an existing value") {
                    storage.set(value: "test", for: .memoryString)
                    let result = storage.remove(key: .memoryString)
                    expect(result).to(beTrue())
                    let value: String? = storage.get(key: .memoryString)
                    expect(value).to(beNil())
                }
                
                it("should clean all existing values") {
                    storage.set(value: 15, for: .memoryInt)
                    storage.set(value: "test", for: .memoryString)
                    let result = storage.clean(type: .memory)
                    expect(result).to(beTrue())
                    let stringValue: String? = storage.get(key: .memoryString)
                    expect(stringValue).to(beNil())
                    let intValue: Int? = storage.get(key: .memoryInt)
                    expect(intValue).to(beNil())
                }
            }
            
            // MARK: - UserDefaults
            
            context("defaults") {
                
                it("should return nil when trying to get a non existent value") {
                    let value: String? = storage.get(key: .defaultsString)
                    expect(value).to(beNil())
                }
                
                it("should return nil when trying to get a non existent raw value") {
                    let value = storage.getRaw(key: .defaultsString)
                    expect(value).to(beNil())
                }
                
                it("should store a valid value") {
                    let result = storage.set(value: "test", for: .defaultsString)
                    expect(result).to(beTrue())
                    let value: String? = storage.get(key: .defaultsString)
                    expect(value).toNot(beNil())
                    expect(value).to(equal("test"))
                    let rawValue = storage.getRaw(key: .defaultsString)
                    expect(rawValue).toNot(beNil())
                }
                
                it("should remove an existing value") {
                    storage.set(value: "test", for: .defaultsString)
                    let result = storage.remove(key: .defaultsString)
                    expect(result).to(beTrue())
                    let value: String? = storage.get(key: .defaultsString)
                    expect(value).to(beNil())
                }
                
                it("should clean all existing values") {
                    storage.set(value: 15, for: .defaultsInt)
                    storage.set(value: "test", for: .defaultsString)
                    let result = storage.clean(type: .defaults)
                    expect(result).to(beTrue())
                    let stringValue: String? = storage.get(key: .defaultsString)
                    expect(stringValue).to(beNil())
                    let intValue: Int? = storage.get(key: .defaultsInt)
                    expect(intValue).to(beNil())
                }
            }
            
            // MARK: - Keychain
            
            context("keychain") {
                
                it("should return nil when trying to get a non existent value") {
                    let value: String? = storage.get(key: .keychainString)
                    expect(value).to(beNil())
                }
                
                it("should return nil when trying to get a non existent raw value") {
                    let value = storage.getRaw(key: .keychainString)
                    expect(value).to(beNil())
                }
                
                it("should store a valid value") {
                    let result = storage.set(value: "test", for: .keychainString)
                    expect(result).to(beTrue())
                    let value: String? = storage.get(key: .keychainString)
                    expect(value).toNot(beNil())
                    expect(value).to(equal("test"))
                    let rawValue = storage.getRaw(key: .keychainString)
                    expect(rawValue).toNot(beNil())
                }
                
                it("should remove an existing value") {
                    storage.set(value: "test", for: .keychainString)
                    let result = storage.remove(key: .keychainString)
                    expect(result).to(beTrue())
                    let value: String? = storage.get(key: .keychainString)
                    expect(value).to(beNil())
                }
                
                it("should clean all existing values") {
                    storage.set(value: 15, for: .keychainInt)
                    storage.set(value: "test", for: .keychainString)
                    let result = storage.clean(type: .keychain)
                    expect(result).to(beTrue())
                    let stringValue: String? = storage.get(key: .keychainString)
                    expect(stringValue).to(beNil())
                    let intValue: Int? = storage.get(key: .keychainInt)
                    expect(intValue).to(beNil())
                }
            }
            
            // MARK: - Clean All
            
            context("cleanAll") {
                
                it("should clean all existing values from all stores") {
                    let num = 15
                    let str = "test"
                    
                    storage.set(value: num, for: .memoryInt)
                    storage.set(value: str, for: .memoryString)
                    storage.set(value: num, for: .defaultsInt)
                    storage.set(value: str, for: .defaultsString)
                    storage.set(value: num, for: .keychainInt)
                    storage.set(value: str, for: .keychainString)
                    
                    let result = storage.cleanAll()
                    expect(result).to(beTrue())
                    
                    let memoryInt: Int? = storage.get(key: .memoryInt)
                    expect(memoryInt).to(beNil())
                    let memoryString: String? = storage.get(key: .memoryString)
                    expect(memoryString).to(beNil())
                    
                    let defaultsInt: Int? = storage.get(key: .defaultsInt)
                    expect(defaultsInt).to(beNil())
                    let defaultsString: String? = storage.get(key: .defaultsString)
                    expect(defaultsString).to(beNil())
                    
                    let keychainInt: Int? = storage.get(key: .keychainInt)
                    expect(keychainInt).to(beNil())
                    let keychainString: String? = storage.get(key: .keychainString)
                    expect(keychainString).to(beNil())
                }
            }
            
            // MARK: - Memory Only
            
            context("memoryOnly") {
                
                var defaults: UserDefaults!
                
                beforeEach {
                    defaults = UserDefaults()
                    storage = KeyValueStorage(defaults: defaults)
                    storage.memoryOnly = true
                }
                
                it("should store any value in memory when memoryOnly is true") {
                    storage.set(value: "test", for: .defaultsString)
                    
                    let defaultsValue = defaults.data(forKey: "defaultsString")
                    expect(defaultsValue).to(beNil())
                    
                    var memoryValue: String? = storage.get(key: .defaultsString)
                    expect(memoryValue).toNot(beNil())
                    
                    let result = storage.clean(type: .defaults)
                    expect(result).to(beTrue())
                    
                    memoryValue = storage.get(key: .defaultsString)
                    expect(memoryValue).to(beNil())
                }
                
                it("should synchronize when memoryOnly is true") {
                    storage.set(value: "test", for: .defaultsString)
                    
                    var defaultsValue = defaults.data(forKey: "defaultsString")
                    expect(defaultsValue).to(beNil())
                    
                    storage.synchronize()
                    
                    defaultsValue = defaults.data(forKey: "defaultsString")
                    expect(defaultsValue).toNot(beNil())
                }
            }
        }
    }
}

// MARK: - Private Helpers

private extension KeyValueStorageKey {
    
    static let memoryInt = KeyValueStorageKey(type: .memory, value: "memoryInt")
    static let memoryString = KeyValueStorageKey(type: .memory, value: "memoryString")
    
    static let defaultsInt = KeyValueStorageKey(type: .defaults, value: "defaultsInt")
    static let defaultsString = KeyValueStorageKey(type: .defaults, value: "defaultsString")
    
    static let keychainInt = KeyValueStorageKey(type: .keychain, value: "keychainInt")
    static let keychainString = KeyValueStorageKey(type: .keychain, value: "keychainString")
}
