//
//  CreatorTest.swift
//  mobniusTests
//
//  Created by Александр Краснов on 11.04.2021.
//

import XCTest

import mobnius

class CreatorTest: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGenerate() throws {
        let creator = Creator(isZip: false)
        let to: RPCItem<String> = RPCItem.init("cs_users", "Query", nil)
        
        creator.addTo(item: to)
        creator.addFile(name: "readme.txt", key: "readme", bytes: Utils.toBytes(str: "Hello"))
        creator.addFile(name: "readme2.txt", key: "readme2", bytes: Utils.toBytes(str: "World"))
        
        let from: RPCItem<String> = RPCItem.init("cs_users", "Query", nil)
        creator.addFrom(item: from)
        
        let bytes: [UInt8] = creator.generate(tid: UUID().uuidString)
        XCTAssert(bytes.count == 558)
        XCTAssertNotNil(bytes)
    }
}
