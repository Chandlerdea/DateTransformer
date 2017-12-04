//
//  TimeIntervalToStringTransformer.swift
//  DateTransformerTests
//
//  Created by Chandler De Angelis on 12/2/17.
//  Copyright © 2017 Chandler De Angelis. All rights reserved.
//

import XCTest
@testable import DateTransformer

class TimeIntervalToStringTransformerTest: XCTestCase {
    
    func testThatStringFromTimeIntervalWithDefaultFormatIsCorrect() {
        let expectedResult: String = "Saturday, Jan 3, 1970"
        let hourMeasurement: Measurement = Measurement(value: 48, unit: UnitDuration.hours)
        let seconds: Double = hourMeasurement.converted(to: UnitDuration.seconds).value
        let transformer: TimeIntervalToStringTransformer = TimeIntervalToStringTransformer()
        let result: String? = transformer.transformTimeInterval(seconds, timeZone: TimeZone(secondsFromGMT: 0)!)
        XCTAssertEqual(expectedResult, result)
    }
    
    func testThatStringFromTimeIntervalWithCustomFormatIsCorrect() {
        let expectedResult: String = "1:30 PM"
        let hourMeasurement: Measurement = Measurement(value: 13.5, unit: UnitDuration.hours)
        let seconds: Double = hourMeasurement.converted(to: UnitDuration.seconds).value
        let format: String = "h:mm a"
        let transformer: TimeIntervalToStringTransformer = TimeIntervalToStringTransformer(dateFormat: format)
        let result: String? = transformer.transformTimeInterval(seconds, timeZone: TimeZone(secondsFromGMT: 0)!)
        XCTAssertEqual(expectedResult, result)
    }
    
}
