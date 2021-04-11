//
//  UtilsTest.swift
//  mobniusTests
//
//  Created by Александр Краснов on 06.04.2021.
//

import XCTest

import mobnius

class UtilsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertDateToInt() throws {
        XCTAssertTrue(Utils.convertDateToInt(Date()) > 0)
        XCTAssertTrue(Utils.convertDateToInt(nil) > 0)
    }
    
    func testJsonStringWithObject() {
        let obj = ExampleJson<String>();
        obj.name = "test"
        obj.params = [Params.string("Hello"), Params.bool(true), Params.integer(0), Params.null]
        
        let jsonString = Utils.encodeJson(obj)
        XCTAssert(jsonString == "{\"name\":\"test\",\"params\":[\"Hello\",true,0,null]}")
    }
    
    class ExampleJson<T: Codable>: Codable {
        var name: String = ""
        var params: [Params<T>] = []
    }
}
