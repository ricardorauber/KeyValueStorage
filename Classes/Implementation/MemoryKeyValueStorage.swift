/// Implementation of the KeyValueStorage protocol using a dictionary
public class MemoryKeyValueStorage {
	
	var storage: [String: Any]
	
	// MARK: - Initialization
	
	/// Creates a new instance of the MemoryKeyValueStorage
	/// - Parameter storage: A dictionary or nil for an empty dictionary
	public init(storage: [String: Any]? = nil) {
		self.storage = storage ?? [:]
	}
}

// MARK: - KeyValueStorage
extension MemoryKeyValueStorage: KeyValueStorage {
	
	// MARK: - Data
	
	@discardableResult
	public func set(data: Data, for key: StorageKey) -> Bool {
		return set(data: data, for: key.rawValue)
	}
	
	@discardableResult
	public func set(data: Data, for key: String) -> Bool {
		storage[key] = data
		return true
	}
	
	public func getData(for key: StorageKey) -> Data? {
		return getData(for: key.rawValue)
	}
	
	public func getData(for key: String) -> Data? {
		return storage[key] as? Data
	}
	
	// MARK: - String
	
	@discardableResult
	public func set(string: String, for key: StorageKey) -> Bool {
		return set(string: string, for: key.rawValue)
	}
	
	@discardableResult
	public func set(string: String, for key: String) -> Bool {
		storage[key] = string
		return true
	}
	
	public func getString(for key: StorageKey) -> String? {
		return getString(for: key.rawValue)
	}
	
	public func getString(for key: String) -> String? {
		return storage[key] as? String
	}
	
	// MARK: - Int
	
	@discardableResult
	public func set(int: Int, for key: StorageKey) -> Bool {
		return set(int: int, for: key.rawValue)
	}
	
	@discardableResult
	public func set(int: Int, for key: String) -> Bool {
		storage[key] = int
		return true
	}
	
	public func getInt(for key: StorageKey) -> Int? {
		return getInt(for: key.rawValue)
	}
	
	public func getInt(for key: String) -> Int? {
		return storage[key] as? Int
	}
	
	// MARK: - Double
	
	@discardableResult
	public func set(double: Double, for key: StorageKey) -> Bool {
		return set(double: double, for: key.rawValue)
	}
	
	@discardableResult
	public func set(double: Double, for key: String) -> Bool {
		storage[key] = double
		return true
	}
	
	public func getDouble(for key: StorageKey) -> Double? {
		return getDouble(for: key.rawValue)
	}
	
	public func getDouble(for key: String) -> Double? {
		return storage[key] as? Double
	}
	
	// MARK: - Bool
	
	@discardableResult
	public func set(bool: Bool, for key: StorageKey) -> Bool {
		return set(bool: bool, for: key.rawValue)
	}
	
	@discardableResult
	public func set(bool: Bool, for key: String) -> Bool {
		storage[key] = bool
		return true
	}
	
	public func getBool(for key: StorageKey) -> Bool? {
		return getBool(for: key.rawValue)
	}
	
	public func getBool(for key: String) -> Bool? {
		return storage[key] as? Bool
	}
	
	// MARK: - General
	
	@discardableResult
	public func remove(key: StorageKey) -> Bool {
		return remove(key: key.rawValue)
	}
	
	@discardableResult
	public func remove(key: String) -> Bool {
		storage.removeValue(forKey: key)
		return true
	}
	
	@discardableResult
	public func clear() -> Bool {
		storage.removeAll()
		return true
	}
}
