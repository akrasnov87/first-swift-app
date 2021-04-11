//
//  MetaSize.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

/**
информация о чтении мета информации
 */
public class MetaSize {
    /**
    максимальная длина строки
     */
    public static let MAX_LENGTH: Int = 16
    
    /**
    разделитель для заполнения
     */
    static let separator: String = "."
    
    /**
     Статус пакета
     */
    public enum Status: Int {
        /**
        пакет создан
         */
        case CREATED = 0,
        /**
        пакет доставлен
         */
        DELIVERED = 1,
        /**
        в обработке
         */
        PROCESSING = 2,
        /**
        обработан
         */
        PROCESSED = 3,
        /**
        Не доставлен
         */
        UN_DELIVERED = 8,
        /**
        обработан с ошибкой
         */
        PROCESSED_ERROR = 9
    }

    /**
    Длина метаинформации
     */
    var metaSize: Int

    /**
    Статус обработки пакета
     */
    var status: Status

    /**
    Тип пакета
     */
    var type: String

    /**
     Конструктор
     - parameter metaSize: размер блока с метаданными
     - parameter status: статус пакета, по умолчанию CREATED
     */
    public init(metaSize: Int, status: Status, type: String) {
        self.metaSize = metaSize
        self.status = status
        self.type = type
    }

    /**
     Преобразование в строку
     - returns строка
     */
    public func toObjectString() -> String {
        var result = type + String(metaSize)

        for i in 0...MetaSize.MAX_LENGTH - 1 {
            if i >= result.count {
                result.append(MetaSize.separator)
            }
        }
        return result + String(status.rawValue)
    }
}
