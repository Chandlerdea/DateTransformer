//
//  DateToTimestampTransformerTests.swift
//  DateTransformerTests
//
//  Created by Chandler De Angelis on 12/2/17.
//  Copyright © 2017 Chandler De Angelis. All rights reserved.
//

import XCTest
@testable import DateTransformer

class DateToTimestampTransformerTests: XCTestCase {
    
    var transformer: DateToTimestampTransformer!
    
    override func setUp() {
        super.setUp()
        self.transformer = DateToTimestampTransformer()
    }

    func testThatYearTimestampForYearIsCorrect() {
        self.testThatComponentIsCorrect(.year)
    }
    
    func testThatMonthTimestampForYearIsCorrect() {
        self.testThatComponentIsCorrect(.month)
    }
    
    func testThatWeekTimestampForYearIsCorrect() {
        self.testThatComponentIsCorrect(.weekOfMonth)
    }
    
    func testThatDayTimestampForYearIsCorrect() {
        self.testThatComponentIsCorrect(.day)
    }
    
    func testThatMinuteTimestampForYearIsCorrect() {
        self.testThatComponentIsCorrect(.minute)
    }
    
    func testThatSecondTimestampForYearIsCorrect() {
        self.testThatComponentIsCorrect(.second)
    }
    
    func testThatComponentIsCorrect(_ comp: Calendar.Component) {
        let pastDate: Date = Calendar.current.date(byAdding: comp, value: -1, to: Date())!
        let expectedResult: String
        switch comp {
        case .weekOfMonth:
            expectedResult = "1 week ago"
        case .second:
            expectedResult = "Just now"
        default:
            expectedResult = "1 \(String(describing: comp)) ago"
        }
        let result: String? = self.transformer.transformDate(pastDate)
        XCTAssertEqual(result, expectedResult)
    }
    
}
