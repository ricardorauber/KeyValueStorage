/// A struct to be used instead of strings for the keys. To use it, just add a static var in an extension.
public struct StorageKey: RawRepresentable, Equatable, Hashable {
	
	public typealias RawValue = String
	public let rawValue: String
	
	// MARK: - Initialization
	
	public init(rawValue: String) {
		self.rawValue = rawValue
	}
}
