import Security

/// Implementation of the KeyValueStorage protocol using Keychain
public class KeychainKeyValueStorage {
	
	let access: CFString
	let synchronizable: Bool
	let lock = NSLock()
	
	// MARK: - Initialization
	
	/// Creates a new instance of the KeychainKeyValueStorage
	/// - Parameter access: Type of access, defaults to Accessible When Unlocked
	/// - Parameter synchronizable: Specify if it should synchronize between devices
	public init(access: CFString? = nil, synchronizable: Bool? = nil) {
		self.access = access ?? kSecAttrAccessibleWhenUnlocked
		self.synchronizable = synchronizable ?? false
	}
	
	// MARK: - Features
	
	func addSynchronizable(_ query: [CFString: Any], isAdding: Bool = false) -> [CFString: Any] {
		var query = query
		if synchronizable {
			query[kSecAttrSynchronizable] = isAdding ? true : kSecAttrSynchronizableAny
		}
		return query
	}
}

// MARK: - KeyValueStorage
extension KeychainKeyValueStorage: KeyValueStorage {
	
	// MARK: - Data
	
	@discardableResult
	public func set(data: Data, for key: StorageKey) -> Bool {
		return set(data: data, for: key.rawValue)
	}
	
	@discardableResult
	public func set(data: Data, for key: String) -> Bool {
		remove(key: key)
		lock.lock()
		defer { lock.unlock() }
		
		var query: [CFString: Any] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
			kSecValueData: data,
			kSecAttrAccessible: access
		]
		
		query = addSynchronizable(query, isAdding: true)
		return SecItemAdd(query as CFDictionary, nil) == noErr
	}
	
	public func getData(for key: StorageKey) -> Data? {
		return getData(for: key.rawValue)
	}
	
	public func getData(for key: String) -> Data? {
		lock.lock()
		defer { lock.unlock() }
		
		var query: [CFString: Any] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
			kSecMatchLimit: kSecMatchLimitOne,
			kSecReturnData: kCFBooleanTrue as Any
		]
		query = addSynchronizable(query)
		
		var dataFound: AnyObject?
		let result = withUnsafeMutablePointer(to: &dataFound) {
			SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
		}
		
		if result == noErr {
			return dataFound as? Data
		}
		return nil
	}
	
	// MARK: - String
	
	@discardableResult
	public func set(string: String, for key: StorageKey) -> Bool {
		return set(string: string, for: key.rawValue)
	}
	
	@discardableResult
	public func set(string: String, for key: String) -> Bool {
		return set(data: Data(string.utf8), for: key)
	}
	
	public func getString(for key: StorageKey) -> String? {
		return getString(for: key.rawValue)
	}
	
	public func getString(for key: String) -> String? {
		if let data = getData(for: key) {
			return String(data: data, encoding: .utf8)
		}
		return nil
	}
	
	// MARK: - Int
	
	@discardableResult
	public func set(int: Int, for key: StorageKey) -> Bool {
		return set(int: int, for: key.rawValue)
	}
	
	@discardableResult
	public func set(int: Int, for key: String) -> Bool {
		return set(string: "\(int)", for: key)
	}
	
	public func getInt(for key: StorageKey) -> Int? {
		return getInt(for: key.rawValue)
	}
	
	public func getInt(for key: String) -> Int? {
		if let value = getString(for: key) {
			return Int(value)
		}
		return nil
	}
	
	// MARK: - Double
	
	@discardableResult
	public func set(double: Double, for key: StorageKey) -> Bool {
		return set(double: double, for: key.rawValue)
	}
	
	@discardableResult
	public func set(double: Double, for key: String) -> Bool {
		return set(string: "\(double)", for: key)
	}
	
	public func getDouble(for key: StorageKey) -> Double? {
		return getDouble(for: key.rawValue)
	}
	
	public func getDouble(for key: String) -> Double? {
		if let value = getString(for: key) {
			return Double(value)
		}
		return nil
	}
	
	// MARK: - Bool
	
	@discardableResult
	public func set(bool: Bool, for key: StorageKey) -> Bool {
		return set(bool: bool, for: key.rawValue)
	}
	
	@discardableResult
	public func set(bool: Bool, for key: String) -> Bool {
		let bytes: [UInt8] = bool ? [1] : [0]
		let data = Data(bytes)
		return set(data: data, for: key)
	}
	
	public func getBool(for key: StorageKey) -> Bool? {
		return getBool(for: key.rawValue)
	}
	
	public func getBool(for key: String) -> Bool? {
		if let data = getData(for: key), let firstBit = data.first {
			return firstBit == 1
		}
		return nil
	}
	
	// MARK: - General
	
	@discardableResult
	public func remove(key: StorageKey) -> Bool {
		return remove(key: key.rawValue)
	}
	
	@discardableResult
	public func remove(key: String) -> Bool {
		lock.lock()
		defer { lock.unlock() }
		var query: [CFString: Any] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key
		]
		query = addSynchronizable(query)
		return SecItemDelete(query as CFDictionary) == noErr
	}
	
	@discardableResult
	public func clear() -> Bool {
		lock.lock()
		defer { lock.unlock() }
		var query: [CFString: Any] = [
			kSecClass: kSecClassGenericPassword
		]
		query = addSynchronizable(query)
		return SecItemDelete(query as CFDictionary) == noErr
	}
}
