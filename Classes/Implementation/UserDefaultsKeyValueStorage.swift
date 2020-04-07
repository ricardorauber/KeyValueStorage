import Foundation

/// Implementation of the KeyValueStorage protocol using UserDefaults
public class UserDefaultsKeyValueStorage {
	
	let storage: UserDefaults
	let lock = NSLock()
	
	// MARK: - Initialization
	
	/// Creates a new instance of the UserDefaultsKeyValueStorage
	/// - Parameter storage: A UserDefaults instance or nil for the standard one
	public init(storage: UserDefaults? = nil) {
		self.storage = storage ?? UserDefaults.standard
	}
}

// MARK: - KeyValueStorage
extension UserDefaultsKeyValueStorage: KeyValueStorage {
	
	// MARK: - Data
	
	@discardableResult
	public func set(data: Data, for key: StorageKey) -> Bool {
		return set(data: data, for: key.rawValue)
	}
	
	@discardableResult
	public func set(data: Data, for key: String) -> Bool {
		lock.lock()
		defer { lock.unlock() }
		storage.set(data, forKey: key)
		return true
	}
	
	public func getData(for key: StorageKey) -> Data? {
		return getData(for: key.rawValue)
	}
	
	public func getData(for key: String) -> Data? {
		lock.lock()
		defer { lock.unlock() }
		return storage.data(forKey: key)
	}
	
	// MARK: - String
	
	@discardableResult
	public func set(string: String, for key: StorageKey) -> Bool {
		return set(string: string, for: key.rawValue)
	}
	
	@discardableResult
	public func set(string: String, for key: String) -> Bool {
		lock.lock()
		defer { lock.unlock() }
		storage.set(string, forKey: key)
		return true
	}
	
	public func getString(for key: StorageKey) -> String? {
		return getString(for: key.rawValue)
	}
	
	public func getString(for key: String) -> String? {
		return storage.value(forKey: key) as? String
	}
	
	// MARK: - Int
	
	@discardableResult
	public func set(int: Int, for key: StorageKey) -> Bool {
		return set(int: int, for: key.rawValue)
	}
	
	@discardableResult
	public func set(int: Int, for key: String) -> Bool {
		lock.lock()
		defer { lock.unlock() }
		storage.set(int, forKey: key)
		return true
	}
	
	public func getInt(for key: StorageKey) -> Int? {
		return getInt(for: key.rawValue)
	}
	
	public func getInt(for key: String) -> Int? {
		return storage.value(forKey: key) as? Int
	}
	
	// MARK: - Double
	
	@discardableResult
	public func set(double: Double, for key: StorageKey) -> Bool {
		return set(double: double, for: key.rawValue)
	}
	
	@discardableResult
	public func set(double: Double, for key: String) -> Bool {
		lock.lock()
		defer { lock.unlock() }
		storage.set(double, forKey: key)
		return true
	}
	
	public func getDouble(for key: StorageKey) -> Double? {
		return getDouble(for: key.rawValue)
	}
	
	public func getDouble(for key: String) -> Double? {
		return storage.value(forKey: key) as? Double
	}
	
	// MARK: - Bool
	
	@discardableResult
	public func set(bool: Bool, for key: StorageKey) -> Bool {
		return set(bool: bool, for: key.rawValue)
	}
	
	@discardableResult
	public func set(bool: Bool, for key: String) -> Bool {
		lock.lock()
		defer { lock.unlock() }
		storage.set(bool, forKey: key)
		return true
	}
	
	public func getBool(for key: StorageKey) -> Bool? {
		return getBool(for: key.rawValue)
	}
	
	public func getBool(for key: String) -> Bool? {
		return storage.value(forKey: key) as? Bool
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
		storage.synchronize()
		storage.removeObject(forKey: key)
		storage.synchronize()
		return true
	}
	
	@discardableResult
	public func clear() -> Bool {
		lock.lock()
		defer { lock.unlock() }
		storage.synchronize()
		storage.dictionaryRepresentation().keys.forEach { key in
			storage.removeObject(forKey: key)
		}
		storage.synchronize()
		return true
	}
}
