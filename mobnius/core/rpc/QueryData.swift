//
//  QueryData.swift
//  mobnius
//
//  Created by Александр Краснов on 10.04.2021.
//

import Foundation

open class QueryData: ObjectStringable, Codable {
    
    public init() {
        alias = ""
        select = ""
        query = ""
        page = 1
        start = 0
        limit = 25
        filter = []
        sort = []
    }
    
    public var alias: String
    public var select: String
    public var query: String
    public var page: Int
    public var start: Int
    public var limit: Int
    public var filter: [Params<String>]
    public var sort: [SortItem]

    public func toJsonString() -> String {
        return Utils.encodeJson(self)!
    }
}
