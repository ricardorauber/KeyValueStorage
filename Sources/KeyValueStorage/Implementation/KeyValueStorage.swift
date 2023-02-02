import Foundation
import Security

public class KeyValueStorage {
    
    // MARK: - Dependencies
    
    private let encoder: Encoder
    private let decoder: Decoder
    private let lock = NSLock()
    
    // MARK: - Stores
    
    private var memory: [KeyValueStorageKey: Data]
    private var defaults: UserDefaults
    
    // MARK: - Properties
    
    public var memoryOnly = false
    
    // MARK: - Initialization
    
    public init(encoder: Encoder = JSONEncoder(),
                decoder: Decoder = JSONDecoder(),
                memory: [KeyValueStorageKey: Data] = [:],
                defaults: UserDefaults = UserDefaults.standard) {
        
        self.encoder = encoder
        self.decoder = decoder
        self.memory = memory
        self.defaults = defaults
    }
}

// MARK: - Memory
extension KeyValueStorage {
    
    private func setOnMemory(value: Data, for key: KeyValueStorageKey) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        memory[key] = value
        return true
    }
    
    private func getFromMemory(key: KeyValueStorageKey) -> Data? {
        lock.lock()
        defer { lock.unlock() }
        return memory[key]
    }
    
    private func removeFromMemory(key: KeyValueStorageKey) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        memory.removeValue(forKey: key)
        return true
    }
    
    private func cleanMemory() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        memory.removeAll()
        return true
    }
}

// MARK: - UserDefaults
extension KeyValueStorage {
    
    private func setOnDefaults(value: Data, for key: KeyValueStorageKey) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        defaults.set(value, forKey: key.value)
        return true
    }
    
    private func getFromDefaults(key: KeyValueStorageKey) -> Data? {
        lock.lock()
        defer { lock.unlock() }
        return defaults.data(forKey: key.value)
    }
    
    private func removeFromDefaults(key: KeyValueStorageKey) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        defaults.removeObject(forKey: key.value)
        return true
    }
    
    private func cleanDefaults() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key)
        }
        return true
    }
}

// MARK: - Keychain
extension KeyValueStorage {
    
    private func makeKeychainQuery(key: String? = nil,
                                   value: Data? = nil,
                                   loadData: Bool = false,
                                   onlyTheFirst: Bool = false) -> CFDictionary {
        
        var query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword
        ]
        if let key = key {
            query[kSecAttrAccount] = key
        }
        if let value = value {
            query[kSecValueData] = value
        }
        if loadData {
            query[kSecReturnData] = kCFBooleanTrue
        }
        if onlyTheFirst {
            query[kSecMatchLimit] = kSecMatchLimitOne
        }
        return query as CFDictionary
    }
    
    @discardableResult
    private func removeFromKeychainWithoutLock(query: CFDictionary) -> Bool {
        let status = SecItemDelete(query)
        return status == noErr
    }
    
    private func setOnKeychain(value: Data, for key: KeyValueStorageKey) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        var query = makeKeychainQuery(key: key.value)
        removeFromKeychainWithoutLock(query: query)
        query = makeKeychainQuery(key: key.value, value: value)
        let status = SecItemAdd(query, nil)
        return status == noErr
    }
    
    private func getFromKeychain(key: KeyValueStorageKey) -> Data? {
        lock.lock()
        defer { lock.unlock() }
        let query = makeKeychainQuery(key: key.value, loadData: true, onlyTheFirst: true)
        var result: AnyObject?
        let resultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query, UnsafeMutablePointer($0))
        }
        if resultCode == noErr {
            return result as? Data
        }
        return nil
    }
    
    private func removeFromKeychain(key: KeyValueStorageKey) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        let query = makeKeychainQuery(key: key.value)
        return removeFromKeychainWithoutLock(query: query)
    }
    
    private func cleanKeychain() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        let query = makeKeychainQuery()
        return removeFromKeychainWithoutLock(query: query)
    }
}

// MARK: - KeyValueStorageProtocol
extension KeyValueStorage: KeyValueStorageProtocol {
    
    @discardableResult
    public func set<Type: Codable>(value: Type, for key: KeyValueStorageKey) -> Bool {
        guard let data = try? encoder.encode(value) else { return false }
        if memoryOnly { return setOnMemory(value: data, for: key) }
        switch key.type {
        case .keychain: return setOnKeychain(value: data, for: key)
        case .defaults: return setOnDefaults(value: data, for: key)
        case .memory: return setOnMemory(value: data, for: key)
        }
    }
    
    public func get<Type: Codable>(key: KeyValueStorageKey) -> Type? {
        guard let data = getRaw(key: key) else { return nil }
        return try? decoder.decode(Type.self, from: data)
    }
    
    public func getRaw(key: KeyValueStorageKey) -> Data? {
        if memoryOnly { return getFromMemory(key: key) }
        switch key.type {
        case .keychain: return getFromKeychain(key: key)
        case .defaults: return getFromDefaults(key: key)
        case .memory: return getFromMemory(key: key)
        }
    }
    
    @discardableResult
    public func remove(key: KeyValueStorageKey) -> Bool {
        if memoryOnly { return removeFromMemory(key: key) }
        switch key.type {
        case .keychain: return removeFromKeychain(key: key)
        case .defaults: return removeFromDefaults(key: key)
        case .memory: return removeFromMemory(key: key)
        }
    }
    
    @discardableResult
    public func clean(type: KeyValueStorageType) -> Bool {
        if memoryOnly { return cleanMemory() }
        switch type {
        case .keychain: return cleanKeychain()
        case .defaults: return cleanDefaults()
        case .memory: return cleanMemory()
        }
    }
    
    @discardableResult
    public func cleanAll() -> Bool {
        guard clean(type: .memory),
            clean(type: .defaults),
            clean(type: .keychain)
            else {
                return false
        }
        return true
    }
    
    public func synchronize() {
        guard memoryOnly else { return }
        memoryOnly = false
        for (key, value) in memory {
            set(value: value, for: key)
        }
        memoryOnly = true
    }
}
