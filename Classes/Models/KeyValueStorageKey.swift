import Foundation

public struct KeyValueStorageKey: Equatable, Hashable {
    
    // MARK: - Properties
    
    public let type: KeyValueStorageType
    public let value: String
    
    // MARK: - Initialization
    
    public init(type: KeyValueStorageType, value: String) {
        self.type = type
        self.value = value
    }
}
