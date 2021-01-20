//
//  BreakingBadCharactersTests.swift
//  BreakingBadCharactersTests
//
//  Created by Srujan on 12/01/21.
//

import XCTest
@testable import BreakingBadCharacters

class BreakingBadCharactersTests: XCTestCase {
    var viewModel = BadCharactersViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = BadCharactersViewModel()
        initialize()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAll() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        testAllSeasons()
        testFilterByText()
    }
    
    func initialize() {
        if let path = Bundle.main.path(forResource: "ResponseStub", ofType: "json") {
            guard let  data = NSData(contentsOfFile: path) else {
                print("Invalid data")
                XCTAssertFalse(true)
                return
            }
            XCTAssertTrue(viewModel.parseBadCharacters(data : data as Data))
        }
    }
    
    func testAllSeasons(){
        XCTAssertEqual(viewModel.getSeasons(), [1,2,3,4,5])
    }
    
    func testFilterByText(){
        viewModel.applyFilter(text: "Adam"){
            XCTAssertEqual(viewModel.filteredBadCharacters.last!.name,"Adam Pinkman")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
