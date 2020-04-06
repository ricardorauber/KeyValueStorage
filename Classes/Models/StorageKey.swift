public struct StorageKey: RawRepresentable, Equatable, Hashable {
	
	public typealias RawValue = String
	public let rawValue: String
	
	// MARK: - Initialization
	
	public init(rawValue: String) {
		self.rawValue = rawValue
	}
}
