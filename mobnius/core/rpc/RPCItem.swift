//
//  RPCItem.swift
//  mobnius
//
//  Created by Александр Краснов on 06.04.2021.
//

import Foundation

open class RPCItem<T: Codable>: ObjectStringable, Codable {
    /**
    Действие
     */
    public var action: String = ""
    /**
    Метод
     */
    public var method: String = ""
    /**
    данные для передачи
     */
    public var data: [Params<T>] = []
    /**
    тип, всегда rpc
     */
    public var type: String = "rpc";
    /**
    код запроса. в рамка группы должен быть уникален
     */
    public var tid: Int;

    public var change: Double = 0.0;
    
    public init() {
        tid = Utils.convertDateToInt(nil);
    }

    public convenience init(_ action: String, _ method: String, _ simpleItemQuery: QueryItem?) {
        self.init(action + "." + method, simpleItemQuery)
    }

    public convenience init(_ actionMethod: String, _ simpleItemQuery: QueryItem?) {
        self.init()
        
        let items: [String] = actionMethod.components(separatedBy: ".")

        action = items[0]
        method = items[1]
        
        if(simpleItemQuery != nil) {
            data.append(Params.simpleItemQuery(simpleItemQuery!))
        } else {
            data.append(Params.null)
        }
    }

    public convenience init(_ _action: String, _ _method: String, _ queryData: QueryData) {
        self.init()

        action = _action
        method = _method
        data.append(Params.queryData(queryData))
    }

    /**
     Объект для добавления записей
     - parameter action: сущность
     - parameter items: список объектов
     - returns объект
     */
    public static func addItems(_ action: String, _ items: [T]) -> RPCItem {
        let rpcItem = RPCItem()
        rpcItem.method = "Add"
        rpcItem.action = action
        rpcItem.data.append(Params.object(ParamObject.array(items)))

        return rpcItem
    }

    /**
    Объект для обновления записей
    - parameter action: сущность
    - parameter items: список объектов
    - returns объект
     */
    public static func updateItems(_ action: String, _ items: [T]) -> RPCItem {
        let rpcItem = RPCItem()
        rpcItem.method = "Update"
        rpcItem.action = action
        rpcItem.data.append(Params.object(ParamObject.array(items)))

        return rpcItem
    }

    /**
    Объект для удаления записей
    - parameter action: сущность
    - parameter items: список объектов
    - returns объект
     */
    public static func deleteItems(_ action: String, _ items: [T]) -> RPCItem {
        let rpcItem = RPCItem()
        rpcItem.method = "Delete"
        rpcItem.action = action
        rpcItem.data.append(Params.object(ParamObject.array(items)))

        return rpcItem
    }

    /**
    Объект для добавления записи
    - parameter action: сущность
    - parameter item: объект
    - returns объект
     */
    public static func addItem(_ action: String, _ item: T) -> RPCItem {
        let rpcItem = RPCItem()
        rpcItem.method = "AddOrUpdate"
        rpcItem.action = action
        
        var items: [T] = []
        items.append(item)
        
        rpcItem.data.append(Params.object(ParamObject.array(items)))

        return rpcItem
    }

    /**
    Объект для удаления записb
    
    - parameter action: сущность
    - parameter item: список объектов
    - returns объект
     */
    public static func deleteItem(_ action: String, _ item: T) -> RPCItem {
        let rpcItem = RPCItem()
        rpcItem.method = "Delete"
        rpcItem.action = action
        
        var items: [T] = []
        items.append(item)
        
        rpcItem.data.append(Params.object(ParamObject.array(items)))

        return rpcItem
    }

    public func toJsonString() -> String {
        return Utils.encodeJson(self)!
    }
}
