//
//  ExampleJson.swift
//  mobniusTests
//
//  Created by Александр Краснов on 06.04.2021.
//

import Foundation

import mobnius

class ExampleJson: ObjectToJson {
    var name: String
    var params: [Any]
    
    override init() {
        name = "";
        params = [""]
        super.init()
    }
}
