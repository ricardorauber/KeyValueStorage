import Foundation

public protocol Encoder {
    
    func encode<Type: Encodable>(_ value: Type) throws -> Data
}

extension JSONEncoder: Encoder {}
