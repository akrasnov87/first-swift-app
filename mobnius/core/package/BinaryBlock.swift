//
//  BinaryBlock.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

/**
Блок с бинарными файлами
 */
public class BinaryBlock {

    var items: [FileBinary] = []

    /**
    возвращается список файлов
    - returns список файлов
     */
    public func getFiles() -> [FileBinary] {
        return items
    }

    /**
    добавление в блок бинарного файла
    - parameters name: имя файла
    - parameters key: ключ файла. Должен быть уникальным
    - parameters bytes: масиив данных
     */
    public func add(name: String, key: String, bytes: [UInt8]) {
        items.append(FileBinary(name: name, key: key, bytes: bytes))
    }

    /**
    текущий блок превращается в массив байтов
    - returns массив байтов
     */
    public func toBytes() -> [UInt8] {
        if items.count == 0 {
            let buf: [UInt8] = []
            return buf
        }

        var length: Int = 0
        for i in 0...items.count - 1 {
            length += items[i].bytes.count
        }

        var allByteArray: [UInt8] = []

        for i in 0...items.count - 1 {
            allByteArray.append(contentsOf: items[i].bytes)
        }

        return allByteArray
    }

    /**
    информация для метаописания
    - returns возвращается массив вложений
     */
    public func getAttachments() -> [MetaAttachment] {
        if items.count == 0 {
            let array: [MetaAttachment] = []
            return array
        }

        var attachments: [MetaAttachment] = []
        for i in 0...items.count - 1 {
            let item: FileBinary = items[i]
            let attachement: MetaAttachment = MetaAttachment(size: item.bytes.count, name: item.name, key: item.key)
            attachments.append(attachement)
        }
        
        return attachments
    }

    /**
    очистка данных
     */
    public func clear() {
        items.removeAll()
    }
}
