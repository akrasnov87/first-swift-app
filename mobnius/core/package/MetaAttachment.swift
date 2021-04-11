//
//  MetaAttachment.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

/**
Вложенный файл
 */
public class MetaAttachment: ObjectStringable, Codable {
    
    /**
    размер вложения
     */
    public var size: Int

    /**
    имя файла или относительный путь
     */
    public var name: String

    /**
    ключ вложения
     */
    public var key: String

    /**
    конструктор
    - parameter size: размер
    - parameter name: имя файла
    - parameter key: ключ
     */
    public init(size: Int, name: String, key: String) {
        self.size = size
        self.key = key
        self.name = name
    }
    
    public func toJsonString() -> String {
        return Utils.encodeJson(self)!
    }
}
