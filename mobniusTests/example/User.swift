//
//  User.swift
//  mobniusTests
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

class User: Codable {
    var name: String
    var id: Int
    
    init(_ id: Int, _ name: String) {
        self.id = id
        self.name = name
    }
}
