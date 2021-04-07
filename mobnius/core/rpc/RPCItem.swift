//
//  RPCItem.swift
//  mobnius
//
//  Created by Александр Краснов on 06.04.2021.
//

import Foundation

struct RPCItem {
    var tid: Int = 0
    var action: String = ""
    var method: String = ""
    let type: String = "rpc"
    var change: Double = 0.0
    var data: [NSObject] = []
}
