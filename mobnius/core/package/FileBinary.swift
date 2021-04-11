//
//  FileBinary.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

/**
Бинарный файл в пакете синхронизации
 */
public class FileBinary {
    /**
    имя файла
     */
    public var name: String
    /**
    ключ файла
     */
    public var key: String
    /**
    Массив байтов
     */
    public var bytes: [UInt8]
    
    public init(name: String, key: String, bytes: [UInt8]) {
        self.name = name
        self.key = key
        self.bytes = bytes
    }
}

