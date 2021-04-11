//
//  SortItem.swift
//  mobnius
//
//  Created by Александр Краснов on 10.04.2021.
//

import Foundation

public class SortItem: ObjectStringable, Codable {
    
    public enum Direction {
        case asc, desc
    }
    
    var property: String
    var direction: String
    
    public init(_ prop: String) {
        property = prop
        direction = "ASC"
    }
    
    public convenience init(_ prop: String, _ dir: Direction) {
        self.init(prop)
        direction = dir == .asc ? "ASC" : "DESC"
    }
    
    public func toJsonString() -> String {
        return Utils.encodeJson(self)!
    }
}
