import KeychainSwift

/// Implementation of the KeyValueStorage protocol using Keychain
public class KeychainKeyValueStorage {
	
	let storage: KeychainSwift
	
	// MARK: - Initialization
	
	/// Creates a new instance of the KeychainKeyValueStorage
	/// - Parameter storage: A KeychainSwift instance or nil for a new one
	public init(storage: KeychainSwift? = nil) {
		self.storage = storage ?? KeychainSwift()
	}
}

// MARK: - KeyValueStorage
extension KeychainKeyValueStorage: KeyValueStorage {
	
	// MARK: - String
	
	@discardableResult
	public func set(string: String, for key: StorageKey) -> Bool {
		return set(string: string, for: key.rawValue)
	}
	
	@discardableResult
	public func set(string: String, for key: String) -> Bool {
		return storage.set(string, forKey: key)
	}
	
	public func getString(for key: StorageKey) -> String? {
		return getString(for: key.rawValue)
	}
	
	public func getString(for key: String) -> String? {
		return storage.get(key)
	}
	
	// MARK: - Int
	
	@discardableResult
	public func set(int: Int, for key: StorageKey) -> Bool {
		return set(int: int, for: key.rawValue)
	}
	
	@discardableResult
	public func set(int: Int, for key: String) -> Bool {
		return storage.set("\(int)", forKey: key)
	}
	
	public func getInt(for key: StorageKey) -> Int? {
		return getInt(for: key.rawValue)
	}
	
	public func getInt(for key: String) -> Int? {
		if let value = storage.get(key) {
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
		return storage.set("\(double)", forKey: key)
	}
	
	public func getDouble(for key: StorageKey) -> Double? {
		return getDouble(for: key.rawValue)
	}
	
	public func getDouble(for key: String) -> Double? {
		if let value = storage.get(key) {
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
		return storage.set(bool, forKey: key)
	}
	
	public func getBool(for key: StorageKey) -> Bool? {
		return getBool(for: key.rawValue)
	}
	
	public func getBool(for key: String) -> Bool? {
		if let value = storage.getBool(key) {
			return value
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
		storage.delete(key)
		return true
	}
	
	@discardableResult
	public func clear() -> Bool {
		storage.clear()
		return true
	}
}
