import Foundation

public protocol KeyValueStorageProtocol {
    
    var memoryOnly: Bool { get set }
    
    @discardableResult
    func set<Type: Codable>(value: Type, for key: KeyValueStorageKey) -> Bool
    
    func get<Type: Codable>(key: KeyValueStorageKey) -> Type?
    
    func getRaw(key: KeyValueStorageKey) -> Data?
    
    @discardableResult
    func remove(key: KeyValueStorageKey) -> Bool
    
    @discardableResult
    func clean(type: KeyValueStorageType) -> Bool
    
    @discardableResult
    func cleanAll() -> Bool
    
    func synchronize()
}
