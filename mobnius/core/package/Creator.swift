//
//  Creator.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

/**
 Упаковщик пакета
 */
public class Creator {
    var binaryBlock: BinaryBlock
    
    var from: [RPCItem<String>]
    var isZip: Bool
    var to: [RPCItem<String>]

    /**
     инициализатор
     - parameter isZip: сжатие - по умолчанию пока ставить false
     */
    public init(isZip: Bool) {
        self.isZip = isZip
        from = []
        to = []
        binaryBlock = BinaryBlock()
    }

    /**
     добавление элемента в блок to
     - parameter item: блок
     */
    public func addTo(item: RPCItem<String>) {
        to.append(item)
    }

    /**
     добавление элементов в блок to
     - parameter items: блоки
     */
    public func addAllTo(items: [RPCItem<String>]) {
        to.append(contentsOf: items)
    }

    /**
     добавление элемента в блок from
     - parameter item: блок
     */
    public func addFrom(item: RPCItem<String>) {
        from.append(item)
    }

    /**
     добавление элементов в блок from
     - parameter items: блоки
     */
    public func addAllFrom(items: [RPCItem<String>]) {
        from.append(contentsOf: items)
    }

    /**
     добавить файл
     - parameter name: имя файла
     - parameter key: ключ файла
     - parameter bytes: массив байтов
     */
    public func addFile(name: String, key: String, bytes: [UInt8]) {
        binaryBlock.add(name: name, key: key, bytes: bytes)
    }

    /**
     генерация пакета
     - parameter tid: идентификатор пакета
     - parameter transaction: выполение пакета в транзакции. По умолчанию ставить false
     - returns массив байтов
     */
    public func generate(tid: String, transaction: Bool) -> [UInt8] {
        var bufferBlockToLength = 0
        var bufferBlockFromLength = 0

        var bytes: [UInt8]

        var stringMapArray: [StringMapItem] = []

        var bufferBlockTo: [UInt8] = []

        var idx = 0
        for item in to {
            let str = item.toJsonString()
            let toBuffer = Utils.toBytes(str: str)

            bufferBlockTo.append(contentsOf: toBuffer)
            bufferBlockToLength += toBuffer.count
            stringMapArray.append(StringMapItem(name: "to" + String(idx), length: toBuffer.count))
            idx += 1
        }

        var bufferBlockFrom:[UInt8] = []

        idx = 0
        for item in from {
            let str = item.toJsonString()
            let fromBuffer = Utils.toBytes(str: str)

            bufferBlockFrom.append(contentsOf: fromBuffer)
            bufferBlockFromLength += fromBuffer.count
            stringMapArray.append(StringMapItem(name: "from" + String(idx), length: fromBuffer.count))
            idx += 1
        }
        
        let stringMap: String = Utils.encodeJson(stringMapArray)!
        let stringMapBytes = Utils.toBytes(str: stringMap)

        let binaryBlockBytes = binaryBlock.toBytes()

        let meta = MetaPackage(tid: tid)
        meta.stringSize = stringMapBytes.count
        meta.binarySize = binaryBlockBytes.count
        meta.attachments = binaryBlock.getAttachments()
        meta.dataInfo = ""
        meta.transaction = transaction
        meta.version = SyncProtocol.V2.rawValue
        meta.bufferBlockToLength = bufferBlockToLength
        meta.bufferBlockFromLength = bufferBlockFromLength
        bytes = Utils.toBytes(str: meta.toJsonString())

        let ms = MetaSize(metaSize: bytes.count, status: .CREATED, type: "NML")
        let metaBytes = Utils.toBytes(str: ms.toObjectString())
        var buff: [UInt8] = []
        buff.append(contentsOf: metaBytes)
        buff.append(contentsOf: bytes)
        buff.append(contentsOf: stringMapBytes)
        buff.append(contentsOf: bufferBlockTo)
        buff.append(contentsOf: bufferBlockFrom)
        buff.append(contentsOf: binaryBlockBytes)
        
        return buff
    }

    /**
     генерация пакета
     - parameter tid: идентификатор пакета
     - returns массив байтов
     */
    public func generate(tid: String) -> [UInt8] {
        return generate(tid: tid, transaction: false)
    }

    /**
     очистка упаковщика
     */
    public func destroy() {
        to.removeAll()
        from.removeAll()
        binaryBlock.clear()
    }
}
