//
//  LowCostTests.swift
//  LowCostTests
//
//  Created by SIRAJ V K on 07/02/18.
//  Copyright © 2018 SIRAJ V K. All rights reserved.
//

import XCTest
@testable import LowCost

class LowCostTests: XCTestCase {
    var homeViewControllerUnderTest : HomeViewController!
    override func setUp() {
        super.setUp()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
        homeViewControllerUnderTest = storyboard.instantiateInitialViewController() as! HomeViewController
       
        //load view hierarchy
        if(homeViewControllerUnderTest != nil) {
            
            homeViewControllerUnderTest.loadView()
            homeViewControllerUnderTest.viewDidLoad()
           
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
   
   
    func testHomeVC_CheckInputTableViewLoadedOrNot() {
        XCTAssertTrue(homeViewControllerUnderTest.tblViewWeight != nil, "Check for TableView Set or Not")
        XCTAssertTrue(homeViewControllerUnderTest.tblViewWeight?.numberOfRows(inSection: 0) == 2, "Check for Table cells are loaded or not")
    }
    func testHomeVC_CheckInputTableViewCellRowLoadedOrNot() {
           var cell: InputCell!
           cell = homeViewControllerUnderTest.tableView(homeViewControllerUnderTest.tblViewWeight!, cellForRowAt: IndexPath(row: 0, section: 0)) as! InputCell
            XCTAssertTrue(cell != nil, "First Row Loaded")
            XCTAssertTrue(cell.lblRow?.text == "Row 1","First Row Populated")

        
    }
    func testHomeVC_CheckInputTableViewCellTextFieldLoaded() {
        var cell: InputCell!
        cell = homeViewControllerUnderTest.tableView(homeViewControllerUnderTest.tblViewWeight!, cellForRowAt: IndexPath(row: 0, section: 0)) as! InputCell
         XCTAssertTrue(cell.txtFieldInput != nil,"TextField CEll Loaded")
        
        
    }
   
    func testHomeVC_TestDeleteButton() {
        let btn = UIButton()
        homeViewControllerUnderTest.btnAddRowAction(sender: btn)
        homeViewControllerUnderTest.btnAddRowAction(sender: btn)
        homeViewControllerUnderTest.btnDeleteRowAction(sender: btn)


        var cell: InputCell!
        cell = homeViewControllerUnderTest.tableView(homeViewControllerUnderTest.tblViewWeight!, cellForRowAt: IndexPath(row: 0, section: 0)) as! InputCell
        XCTAssertTrue(cell.lblRow?.text == "Row 1","Add Button Worked")
        
    }
    func testHomeVC_TestAddButton() {
        let btn = UIButton()
        homeViewControllerUnderTest.btnAddRowAction(sender: btn)
        homeViewControllerUnderTest.btnAddRowAction(sender: btn)
        
        var cell: InputCell!
        cell = homeViewControllerUnderTest.tableView(homeViewControllerUnderTest.tblViewWeight!, cellForRowAt: IndexPath(row: 1, section: 0)) as! InputCell
        XCTAssertTrue(cell.lblRow?.text == "Row 2","Add Button Worked")
        
    }
    
    func testHomeVC_OutputLabelsAreLoaded() {
       
        
        XCTAssertTrue(homeViewControllerUnderTest.lblIsTherePath != nil,"Path YES Label Set")
        XCTAssertTrue(homeViewControllerUnderTest.lblPath != nil,"Path Label Set")
        XCTAssertTrue(homeViewControllerUnderTest.lblPathTotalCost != nil,"Path Cost Set")
   }
  
   
    
    func testHomeVC_CostMatrix(){
        let mt = [[1,2,3],[4,5,6],[7,8,9]]
        let costmt =  CostMatrix(matrix:mt)
        XCTAssertTrue(costmt.getCostAt(XY: (1,1)) == 1,"Returned Right Cost")
        XCTAssertTrue(costmt.rightXYFrom(XY: (2,1)) == (2,2),"Returned Right XY")
        XCTAssertTrue(costmt.topXYFrom(XY: (2,1)) == (1,2),"Returned Top XY")
        XCTAssertTrue(costmt.bottomXYFrom(XY: (2,1)) == (3,2),"Returned Bottom XY")

    }
    func testHomeVC_ValuesFromInputFieldAreProperlyConvertedToMatrix(){
        let btn = UIButton()
        homeViewControllerUnderTest.btnAddRowAction(sender: btn)
        homeViewControllerUnderTest.btnAddRowAction(sender: btn)
        var row1: InputCell!
        row1  = homeViewControllerUnderTest.tableView(homeViewControllerUnderTest.tblViewWeight!, cellForRowAt: IndexPath(row: 0, section: 0)) as! InputCell
        var row2: InputCell!
        row2  = homeViewControllerUnderTest.tableView(homeViewControllerUnderTest.tblViewWeight!, cellForRowAt: IndexPath(row: 1, section: 0)) as! InputCell
        row1.txtFieldInput?.text = "1 2"
        homeViewControllerUnderTest.textFieldDidEndEditing(row1.txtFieldInput!)
        row2.txtFieldInput?.text = "3 4"
        homeViewControllerUnderTest.textFieldDidEndEditing(row2.txtFieldInput!)

        XCTAssertTrue(homeViewControllerUnderTest.rows[0] == "1 2","Home VC Rows Cost Populated")
       let costmt = homeViewControllerUnderTest.generateMatrixFromInput(source: homeViewControllerUnderTest.rows)
        XCTAssertTrue(costmt.getCostAt(XY: (1,1)) == 1,"Success-Returned Correct Input")
        
    }
    func testHomeVC_CalculateMinimumCost() {
        let btn = UIButton()
        homeViewControllerUnderTest.btnAddRowAction(sender: btn)
        homeViewControllerUnderTest.btnAddRowAction(sender: btn)
        var row1: InputCell!
        row1  = homeViewControllerUnderTest.tableView(homeViewControllerUnderTest.tblViewWeight!, cellForRowAt: IndexPath(row: 0, section: 0)) as! InputCell
        var row2: InputCell!
        row2  = homeViewControllerUnderTest.tableView(homeViewControllerUnderTest.tblViewWeight!, cellForRowAt: IndexPath(row: 1, section: 0)) as! InputCell
        row1.txtFieldInput?.text = "1 2"
        homeViewControllerUnderTest.textFieldDidEndEditing(row1.txtFieldInput!)
        row2.txtFieldInput?.text = "3 4"
        homeViewControllerUnderTest.textFieldDidEndEditing(row2.txtFieldInput!)
        homeViewControllerUnderTest.rows[0] = "1 2"
        homeViewControllerUnderTest.rows[1] = "3 4"
        homeViewControllerUnderTest.findMinimumCostPath(sender: btn)

        XCTAssertTrue(homeViewControllerUnderTest.lblIsTherePath?.text == "YES","Success")
        XCTAssertTrue(homeViewControllerUnderTest.lblPath?.text == "1 1","Success")
        XCTAssertTrue(homeViewControllerUnderTest.lblPathTotalCost?.text == "3","Success")
        
    }
   
    
    
   
    
}
