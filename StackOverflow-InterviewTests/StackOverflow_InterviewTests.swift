//
//  StackOverflow_InterviewTests.swift
//  StackOverflow-InterviewTests
//
//  Created by Neill Barnard on 2020/06/16.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//


//TESTING HELPER FUNCTIONS
import XCTest
@testable import StackOverflow_Interview

class StackOverflow_InterviewTests: XCTestCase {

    func testconvertIntToFullDateString(){
      let result = convertIntToFullDateString(date: 1592933890)
        print(result)
        XCTAssertEqual(result, "Jun 23 2020 at 19:38")
    }
    
    func testconvertIntDateToSearchResultDate(){
    let result =   convertIntDateToSearchResultDate(date: 1592933890)
    XCTAssertEqual(result, "Jun 23 `20")
    }
    
    func testCheckSearchApiCallWorks(){
        var success = false;
        let SoNetworkCallsClass = StackOverflowApiCalls()
        let searchResultObject = searchSOInputObjectModel(title: "ios", page: 1, pagesize: 5)
        SoNetworkCallsClass.fetchSearchResult(searchObjectModel: searchResultObject) { (result) in
            switch result {
            case let .success(data):
                if(data.items.count == 5){
                    success = true
                    XCTAssertTrue(success)
                }
            case .failure(_):
                success = false
                XCTAssertTrue(success)
            }
        }
    }
}
