//: Playground - noun: a place where people can play

import UIKit
import DateTransformer

let stringToDateTransformer: StringToDateTransformer = StringToDateTransformer()

let defaultDateString: String = "1970-01-01T00:00:00+0000"
let defaultDate: Date? = stringToDateTransformer.transformString(defaultDateString, dateFormat: StringToDateTransformer.defaultStringToDateFormat)

let shortDateString: String = "Dec 7, 2017"
let shortDate: Date? = stringToDateTransformer.transformString(shortDateString, dateFormat: "MMMM d, yyyy")

let currentDate: Date = Date()
let shortString: String? = stringToDateTransformer.transformDate(currentDate, dateFormat: "MM/dd/yyyy")
let longString: String? = stringToDateTransformer.transformDate(currentDate, dateFormat: "E, d MMM yyyy HH:mm")

let countdownTransformer: TimeIntervalToStringTransformer = TimeIntervalToStringTransformer(dateFormat: "HH:mm:ss")

let countdownString: String? = countdownTransformer.transformTimeInterval(1234, timeZone: TimeZone(secondsFromGMT: 0)!)
