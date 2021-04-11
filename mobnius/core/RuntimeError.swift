//
//  RuntimeError.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

struct RuntimeError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
