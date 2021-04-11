//
//  MetaSizeTest.swift
//  mobniusTests
//
//  Created by Александр Краснов on 11.04.2021.
//

import XCTest

import mobnius

class PackageTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMetaSize() throws {
        let metaSize = MetaSize(metaSize: 10, status: .CREATED, type: "NML")
        XCTAssert("NML10...........0" == metaSize.toObjectString())
    }
    
    func testFileBinary() throws {
        let str = "Hello"
        let buf: [UInt8] = Array(str.utf8)
        let file = FileBinary(name: "test", key: "test", bytes: buf)
        
        if let string = String(bytes: file.bytes, encoding: .utf8) {
            XCTAssert(string == str)
        } else {
            XCTAssertThrowsError("Ошибка чтения")
        }
    }
    
    func testMetaAttachment() throws {
        let att = MetaAttachment(size: 10, name: "readme.txt", key: "readme")
        
        XCTAssert("{\"name\":\"readme.txt\",\"size\":10,\"key\":\"readme\"}" == att.toJsonString())
    }
    
    func testMetaPackage() throws {
        let package = MetaPackage()
        XCTAssert("{\"binarySize\":0,\"bufferBlockFromLength\":0,\"id\":\""+package.id+"\",\"dataInfo\":\"\",\"transaction\":false,\"bufferBlockToLength\":0,\"stringSize\":0,\"attachments\":[],\"version\":\"\"}" == package.toJsonString())
        
        package.attachments.append(MetaAttachment(size: 10, name: "readme.txt", key: "readme"))
        
        XCTAssert("{\"binarySize\":0,\"bufferBlockFromLength\":0,\"id\":\"" + package.id + "\",\"dataInfo\":\"\",\"transaction\":false,\"bufferBlockToLength\":0,\"stringSize\":0,\"attachments\":[{\"name\":\"readme.txt\",\"size\":10,\"key\":\"readme\"}],\"version\":\"\"}" == package.toJsonString())
    }
}
