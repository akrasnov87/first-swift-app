//
//  MetaPackage.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

public class MetaPackage: ObjectStringable, Codable {
    public var attachments: [MetaAttachment] = []
    public var binarySize = 0
    public var bufferBlockFromLength = 0
    public var bufferBlockToLength = 0
    public var dataInfo = ""
    public var id: String
    public var stringSize = 0
    public var transaction = false
    public var version = ""

    public convenience init() {
        self.init(tid: UUID().uuidString)
    }
    public init(tid: String) {
        id = tid
    }
    
    public func toJsonString() -> String {
        return Utils.encodeJson(self)!
    }
}
