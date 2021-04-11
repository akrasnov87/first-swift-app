//
//  Filter.swift
//  mobnius
//
//  Created by Александр Краснов on 07.04.2021.
//

import Foundation

/**
 Фильтр для RPC
 */
public class FilterItem: ObjectStringable, Codable {
    public func toJsonString() -> String {
        return Utils.encodeJson(self)!
    }
    
    /**
     Свойство
     */
    var property: String
    /**
     Оператор
     */
    var `operator`: String
    /**
     Значение
     */
    var value: Params<String>
    
    /**
     Инициализатор
     - parameter prop: имя свойства
     - parameter val: значение
     */
    public convenience init(_ prop: String, _ val: Params<String>) {
        self.init()
        
        property = prop
        value = val
    }
    
    public init() {
        property = ""
        `operator` = "="
        value = Params<String>.null
    }
    
    /**
     Установить оператор
     - parameter op: оператор сравнения
     */
    public func setOperator(op: String) {
        `operator` = op
    }
}
