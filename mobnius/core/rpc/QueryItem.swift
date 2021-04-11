//
//  SimpleItemQuery.swift
//  mobnius
//
//  Created by Александр Краснов on 06.04.2021.
//

import UIKit

/**
 параметры для RPC запросов
 */
open class QueryItem: ObjectStringable, Codable {
    var limit: Int
    var params: [Params<String>]
    var filter: [Params<String>]
    
    /**
     инициализатор
     - parameter p: массив параметров
     */
    public init(_ p: Params<String>...) {
        limit = 10000
        params = p
        filter = []
    }
    
    public func toJsonString() -> String {
        return Utils.encodeJson(self)!
    }
    
    /**
     устанавливаем фильтры
     - parameter filters: массив фильтров
     */
    public func setFilters(filters: Params<String>...) {
        filter = filters
    }
}
