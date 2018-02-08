//
//  LowestCostFinderTests.swift
//  LowCostTests
//
//  Created by SIRAJ V K on 07/02/18.
//  Copyright © 2018 SIRAJ V K. All rights reserved.
//

import XCTest
@testable import LowCost

class LowestCostFinderTests: XCTestCase {
    var lowestCostFinderUnderTest: LowestCostFinder!
    override func setUp() {
        super.setUp()
        let mt = [[1,2,3],[4,5,6],[7,8,9]]
        let costmt =  CostMatrix(matrix:mt)
        lowestCostFinderUnderTest = LowestCostFinder(costMatrix:costmt)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWhenSingleRowSingleColumnInput() {
        let mt = [[4]]
        let costmt =  CostMatrix(matrix:mt)
        let (success, lowestcost, path) = lowestCostFinderUnderTest.findFrom(costMatrix: costmt)
        XCTAssertTrue(success)
        XCTAssertEqual(4, lowestcost)
        XCTAssertEqual([1], path)
    }
    
    func testWhenSingleRowSingleColumnInput2() {
        let mt = [[8]]
        let costmt =  CostMatrix(matrix:mt)
        let (success, lowestcost, path) = lowestCostFinderUnderTest.findFrom(costMatrix: costmt)
        XCTAssertTrue(success)
        XCTAssertEqual(8, lowestcost)
        XCTAssertEqual([1], path)
    }
    
    func testWhenSingleRowMultipleColumnInput() {
        let mt = [[1,2,3,4]]
        let costmt =  CostMatrix(matrix:mt)
        let (success, lowestcost, path) = lowestCostFinderUnderTest.findFrom(costMatrix: costmt)
        XCTAssertTrue(success)
        XCTAssertEqual(10, lowestcost)
        XCTAssertEqual([1,1,1,1], path)
    }
    
    func test2RowInput1() {
        let mt = [[1,2],[3,4]]
        let costmt =  CostMatrix(matrix:mt)
        let (success, lowestcost, path) = lowestCostFinderUnderTest.findFrom(costMatrix: costmt)
        XCTAssertTrue(success)
        XCTAssertEqual(3, lowestcost)
        XCTAssertEqual([1,1], path)
    }
    
    func test2RowInput2() {
        let mt = [[3,4],[1,2]]
        let costmt =  CostMatrix(matrix:mt)
        let (success, lowestcost, path) = lowestCostFinderUnderTest.findFrom(costMatrix: costmt)
        XCTAssertTrue(success)
        XCTAssertEqual(3, lowestcost)
        XCTAssertEqual([2,2], path)
    }
    
    func testGivenTestCase1() {
        
        let mt = [
            [3,4,1,2,8,6],
            [6,1,8,2,7,4],
            [5,9,3,9,9,5],
            [8,4,1,3,2,6],
            [3,7,2,8,6,4]
        ]
        let costmt =  CostMatrix(matrix:mt)
        let (success, lowestcost, path) = lowestCostFinderUnderTest.findFrom(costMatrix: costmt)
        XCTAssertTrue(success)
        XCTAssertEqual(16, lowestcost)
        XCTAssertEqual([1,2,3,4,4,5], path)
    }
    
    func testGivenTestCase2() {
        
        let mt = [
            [3,4,1,2,8,6],
            [6,1,8,2,7,4],
            [5,9,3,9,9,5],
            [8,4,1,3,2,6],
            [3,7,2,1,2,3]
        ]
        let costmt =  CostMatrix(matrix:mt)
        let (success, lowestcost, path) = lowestCostFinderUnderTest.findFrom(costMatrix: costmt)
        XCTAssertTrue(success)
        XCTAssertEqual(11, lowestcost)
        XCTAssertEqual([1,2,1,5,4,5], path)
    }
    
    func testGivenTestCase3() {
        let mt = [
            [19,10,19,10,19],
            [21,23,20,19,12],
            [20,12,20,11,10]
        ]
        let costmt =  CostMatrix(matrix:mt)
        let (success, lowestcost, path) = lowestCostFinderUnderTest.findFrom(costMatrix: costmt)
        XCTAssertFalse(success)
        XCTAssertEqual(48, lowestcost)
        XCTAssertEqual([1,1,1], path)
    }
    
   
    
}
