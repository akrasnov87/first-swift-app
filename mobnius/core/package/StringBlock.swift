//
//  StringBlock.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

/**
Строковый блок пакета синхронизации
 */
public class StringBlock: ObjectStringable, Codable {

    /**
    блок данных для отправки
     */
    public var to: [RPCItem<String>]

    /**
    блок данных для получения
     */
    public var from: [RPCItem<String>]
    
    public init(to: [RPCItem<String>], from: [RPCItem<String>]) {
        self.to = to
        self.from = from
    }

    public func toJsonString() -> String {
        return Utils.encodeJson(self)!
    }
}
