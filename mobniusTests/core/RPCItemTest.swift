//
//  rpcTest.swift
//  mobniusTests
//
//  Created by Александр Краснов on 10.04.2021.
//

import mobnius

import XCTest

class RPCItemTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilter() throws {
        let item = FilterItem("id", Params.integer(1))
        
        XCTAssert("{\"operator\":\"=\",\"property\":\"id\",\"value\":1}" == item.toJsonString())
        
        item.setOperator(op: "!=")
        
        XCTAssert("{\"operator\":\"!=\",\"property\":\"id\",\"value\":1}" == item.toJsonString())
    }
    
    func testQueryItem() throws {
        let simple = QueryItem(Params.integer(1), Params.string(""))
        XCTAssert("{\"limit\":10000,\"filter\":[],\"params\":[1,\"\"]}" == simple.toJsonString())
        simple.setFilters(filters: Params.filter(FilterItem("id", Params.integer(0))), Params.string("and"), Params.filter(FilterItem("id", Params.integer(1))))
        XCTAssert("{\"limit\":10000,\"filter\":[{\"operator\":\"=\",\"property\":\"id\",\"value\":0},\"and\",{\"operator\":\"=\",\"property\":\"id\",\"value\":1}],\"params\":[1,\"\"]}" == simple.toJsonString())
    }
    
    func testSortItem() throws {
        var sort = SortItem("id")
        XCTAssert("{\"property\":\"id\",\"direction\":\"ASC\"}" == sort.toJsonString())
        sort = SortItem("id", .desc)
        XCTAssert("{\"property\":\"id\",\"direction\":\"DESC\"}" == sort.toJsonString())
    }
    
    func testQueryData() throws {
        let queryData = QueryData();
        XCTAssert("{\"filter\":[],\"alias\":\"\",\"start\":0,\"select\":\"\",\"sort\":[],\"limit\":25,\"query\":\"\",\"page\":1}" == queryData.toJsonString())
    }
    
    func testRPCItem() throws {
        let user = User(0, "Alex")
        
        let deleteRPC = RPCItem.deleteItem("cs_users", user)
        XCTAssert("{\"data\":[[{\"name\":\"Alex\",\"id\":0}]],\"method\":\"Delete\",\"tid\":"+String(deleteRPC.tid)+",\"type\":\"rpc\",\"change\":0,\"action\":\"cs_users\"}" == deleteRPC.toJsonString())
        
        let addRPC = RPCItem.addItem("cs_users", user)
        
        XCTAssert("{\"data\":[[{\"name\":\"Alex\",\"id\":0}]],\"method\":\"AddOrUpdate\",\"tid\":"+String(addRPC.tid)+",\"type\":\"rpc\",\"change\":0,\"action\":\"cs_users\"}" == addRPC.toJsonString())
        
        let user2 = User(2, "Victory")
        
        let array: [User] = [user, user2]
        
        let deleteItems = RPCItem.deleteItems("cs_users", array)
        XCTAssert("{\"data\":[[{\"name\":\"Alex\",\"id\":0},{\"name\":\"Victory\",\"id\":2}]],\"method\":\"Delete\",\"tid\":"+String(deleteItems.tid)+",\"type\":\"rpc\",\"change\":0,\"action\":\"cs_users\"}" == deleteItems.toJsonString())
        
        let updateItems = RPCItem.updateItems("cs_users", array)
        XCTAssert("{\"data\":[[{\"name\":\"Alex\",\"id\":0},{\"name\":\"Victory\",\"id\":2}]],\"method\":\"Update\",\"tid\":"+String(deleteItems.tid)+",\"type\":\"rpc\",\"change\":0,\"action\":\"cs_users\"}" == updateItems.toJsonString())
        
        let addtems = RPCItem.addItems("cs_users", array)
        XCTAssert("{\"data\":[[{\"name\":\"Alex\",\"id\":0},{\"name\":\"Victory\",\"id\":2}]],\"method\":\"Add\",\"tid\":"+String(deleteItems.tid)+",\"type\":\"rpc\",\"change\":0,\"action\":\"cs_users\"}" == addtems.toJsonString())
    }
    
    func testRPCInit() throws {
        let queryItem = QueryItem(Params.bool(true), Params.double(0.0))
        
        var rpc = RPCItem<String>("cs_users", "Query", nil)
        XCTAssert("{\"data\":[null],\"method\":\"Query\",\"tid\":"+String(rpc.tid)+",\"type\":\"rpc\",\"change\":0,\"action\":\"cs_users\"}" == rpc.toJsonString())
        
        rpc = RPCItem<String>("cs_users", "Query", queryItem)
        
        XCTAssert("{\"data\":[{\"limit\":10000,\"filter\":[],\"params\":[true,0]}],\"method\":\"Query\",\"tid\":"+String(rpc.tid)+",\"type\":\"rpc\",\"change\":0,\"action\":\"cs_users\"}" == rpc.toJsonString())
        
        let queryData = QueryData()
        
        rpc = RPCItem<String>("cs_users", "Query", queryData)
        
        XCTAssert("{\"data\":[{\"filter\":[],\"alias\":\"\",\"start\":0,\"select\":\"\",\"sort\":[],\"limit\":25,\"query\":\"\",\"page\":1}],\"method\":\"Query\",\"tid\":" + String(rpc.tid) + ",\"type\":\"rpc\",\"change\":0,\"action\":\"cs_users\"}" == rpc.toJsonString())
    }
}
