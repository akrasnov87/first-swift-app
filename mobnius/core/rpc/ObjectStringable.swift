//
//  RPCObject.swift
//  mobnius
//
//  Created by Александр Краснов on 10.04.2021.
//

import Foundation

/**
 Класс для преобразования в JSON
 */
public protocol ObjectStringable {
    
    /**
     Функция которая возвращает строку для текущего объекта в виде JSON
     - returns: строка в формате JSON
     */
    func toJsonString() -> String
}
