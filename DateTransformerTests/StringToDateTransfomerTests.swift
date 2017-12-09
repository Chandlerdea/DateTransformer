//
//  DateTransformerTests.swift
//  DateTransformerTests
//
//  Created by Chandler De Angelis on 12/2/17.
//  Copyright © 2017 Chandler De Angelis. All rights reserved.
//

import XCTest
@testable import DateTransformer

class DateTransformerTests: XCTestCase {
    
    var transformer: StringToDateTransformer!
    
    override func setUp() {
        super.setUp()
        self.transformer = StringToDateTransformer()
    }
    
    func testThatDateWithDefaultFormatFromStringIsCorrect() {
        let expectedDate: Date = Date(timeIntervalSince1970: 0)
        let dateString: String = "1970-01-01T00:00:00+0000"
        let result: Date? = self.transformer.transformString(dateString)
        XCTAssertEqual(expectedDate, result)
    }
    
    func testThatStringFromDateWithDefaultFormatIsCorrect() {
        let expectedResult: String = "Thursday, Jan 1, 1970"
        let date: Date = Date(timeIntervalSince1970: 0)
        let result: String? = self.transformer.transformDate(date, timeZone: TimeZone(secondsFromGMT: 0)!)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testThatStringFromDateWithCustomFormatIsCorrect() {
        let expectedResult: String = "01/01/1970"
        let date: Date = Date(timeIntervalSince1970: 0)
        let format: String = "MM/dd/yyyy"
        let result: String? = self.transformer.transformDate(date, dateFormat: format, timeZone: TimeZone(secondsFromGMT: 0)!)
        XCTAssertEqual(result, expectedResult)
    }
    
}
