//
//  Utils.swift
//  mobnius
//
//  Created by Александр Краснов on 06.04.2021.
//

import Foundation

public class Utils {
    /**
    Преобразование даты в число
     
    ```
     .convertDateToInt(Date())
    ```
     
    - parameter date: дата для преобразования, можно передать nil, тогда по умолчанию будет текущая дата
     
    - returns: число
     */
    public static func convertDateToInt(_ date: Date?) -> Int {
        let timeInterval: TimeInterval
        if date == nil {
            timeInterval = Date().timeIntervalSince1970
        } else {
            timeInterval = date!.timeIntervalSince1970
        }

        return Int(timeInterval)
    }
    
    /**
     Преобразование объекта в строку в формате JSON
     - parameter _: объект для преобразования в строку
     - returns: строка в формате JSON, если преобразование ошибочное, то вернется nil
     */
    public static func encodeJson<T>(_ value: T) -> String? where T : Encodable {
        guard let jsonData = try? JSONEncoder().encode(value) else {
            return nil
        }
        
        return String(data: jsonData, encoding: .utf8)
    }
}
