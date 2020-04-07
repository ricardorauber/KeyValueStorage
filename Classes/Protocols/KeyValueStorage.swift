/// Protocol to implement Key-Value storage systems
public protocol KeyValueStorage {
	
	// MARK: - Data
	
	/// Sets a data value into the storage
	///
	/// - Parameters:
	///   - data: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(data: Data, for key: StorageKey) -> Bool
	
	/// Sets a data value into the storage
	///
	/// - Parameters:
	///   - data: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(data: Data, for key: String) -> Bool
	
	/// Returns a data value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getData(for key: StorageKey) -> Data?
	
	/// Returns a data value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getData(for key: String) -> Data?
	
	// MARK: - String
	
	/// Sets a string value into the storage
	///
	/// - Parameters:
	///   - string: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(string: String, for key: StorageKey) -> Bool
	
	/// Sets a string value into the storage
	///
	/// - Parameters:
	///   - string: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(string: String, for key: String) -> Bool
	
	/// Returns a string value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getString(for key: StorageKey) -> String?
	
	/// Returns a string value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getString(for key: String) -> String?
	
	// MARK: - Int
	
	/// Sets an integer value into the storage
	///
	/// - Parameters:
	///   - string: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(int: Int, for key: StorageKey) -> Bool
	
	/// Sets an integer value into the storage
	///
	/// - Parameters:
	///   - string: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(int: Int, for key: String) -> Bool
	
	/// Returns an integer value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getInt(for key: StorageKey) -> Int?
	
	/// Returns an integer value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getInt(for key: String) -> Int?
	
	// MARK: - Set Double
	
	/// Sets an double value into the storage
	///
	/// - Parameters:
	///   - string: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(double: Double, for key: StorageKey) -> Bool
	
	/// Sets an double value into the storage
	///
	/// - Parameters:
	///   - string: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(double: Double, for key: String) -> Bool
	
	/// Returns an double value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getDouble(for key: StorageKey) -> Double?
	
	/// Returns an double value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getDouble(for key: String) -> Double?
	
	// MARK: - Bool
	
	/// Sets a boolean value into the storage
	///
	/// - Parameters:
	///   - string: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(bool: Bool, for key: StorageKey) -> Bool
	
	/// Sets a boolean value into the storage
	///
	/// - Parameters:
	///   - string: Value
	///   - key: Key
	/// - Returns: Confirmation
	@discardableResult
	func set(bool: Bool, for key: String) -> Bool
	
	/// Returns a boolean value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getBool(for key: StorageKey) -> Bool?
	
	/// Returns a boolean value from the storage
	///
	/// - Parameter key: Key
	/// - Returns: Value if found
	func getBool(for key: String) -> Bool?
	
	// MARK: - General
	
	/// Removes a value/object for a given key
	///
	/// - Parameter key: Key to identify the record
	/// - Returns: Confirmation
	@discardableResult
	func remove(key: StorageKey) -> Bool
	
	/// Removes a value/object for a given key
	///
	/// - Parameter key: Key to identify the record
	/// - Returns: Confirmation
	@discardableResult
	func remove(key: String) -> Bool
	
	/// Removes all data from the storage
	///
	/// - Returns: Confirmation
	@discardableResult
	func clear() -> Bool
}
