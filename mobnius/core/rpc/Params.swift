//
//  Params.swift
//  mobnius
//
//  Created by Александр Краснов on 07.04.2021.
//

import Foundation

/**
 Перечисление для построения массива с разными типоми данных, которые можно преобразовать в JSON
 https://coderoad.ru/48314724/Swift-Codable-Parse-JSON-массив-который-может-содержать-различные-типы-данных
 
 ```
 let array: [Params] = [bool(true), string("Hello")]
 let jsonData = try! JSONEncoder().encode(array)
 let jsonString = String(array: jsonData, encoding: .utf8)!
 print(jsonString)
 ```
 
 */
public enum Params : Codable {
    case bool(Bool)
    case integer(Int)
    case string(String)
    case double(Double)
    case null
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Params.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Params"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .bool(let x):
                try container.encode(x)
            case .double(let x):
                try container.encode(x)
            case .integer(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
                
            case .null:
                try container.encodeNil()
        }
    }
}
