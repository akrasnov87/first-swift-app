//
//  ParamArray.swift
//  mobnius
//
//  Created by Александр Краснов on 10.04.2021.
//

import Foundation

/**
 Специальный объект для хранение массивов и других объектов, которые являются наследниками Codable
 */
public enum ParamObject<T: Codable>: Codable {
    case array([T])
    case item(T)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([T].self) {
            self = .array(x)
            return
        }
        
        if let x = try? container.decode(T.self) {
            self = .item(x)
            return
        }

        throw DecodingError.typeMismatch(ParamObject<T>.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Params"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .array(let x):
                try container.encode(x)
            case .item(let x):
                try container.encode(x)
        }
    }
}
