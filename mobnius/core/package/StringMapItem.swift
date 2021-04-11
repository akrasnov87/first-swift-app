//
//  StringMapItem.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

public class StringMapItem: ObjectStringable, Codable {
    
    public var length: Int
    public var name: String

    public init(name: String, length: Int) {
        self.name = name
        self.length = length
    }
    
    public func toJsonString() -> String {
        return Utils.encodeJson(self)!
    }
}
