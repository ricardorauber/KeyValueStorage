import Foundation

public protocol Decoder {
    
    func decode<Type: Decodable>(_ type: Type.Type, from data: Data) throws -> Type
}

extension JSONDecoder: Decoder {}
