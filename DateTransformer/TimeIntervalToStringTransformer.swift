//
//  TimeIntervalToStringTransformer.swift
//  DateTransformer
//
//  Created by Chandler De Angelis on 12/1/17.
//

import Foundation

public final class TimeIntervalToStringTransformer: ValueTransformer {
    
    // MARK: - Properties
    
    public static let defaultDateFormat: String = "EEEE, MMM d, yyyy"

    private lazy var dateFormatter: DateFormatter = DateFormatter()

    // MARK: - Init
    
    /**
     - parameter dateFormat: The format that you want the String representation of the interval to be. Defualts to `TimeIntervalToStringTransformer.defaultDateFormat`
    */
    public init(dateFormat: String = TimeIntervalToStringTransformer.defaultDateFormat) {
        super.init()
        self.dateFormatter.dateFormat = dateFormat
    }
    
    /**
     Takes a time interval and returns a string representation of the interval
     - parameter interval: A `TimeInterval`
     - parameter timeZone: A `TimeZone` that will be applied to the date, defaults to `current`
     - returns: A `String`
    */
    public func transformTimeInterval(_ interval: TimeInterval, timeZone: TimeZone = .current) -> String? {
        self.dateFormatter.timeZone = timeZone
        return self.transformedValue(interval) as? String
    }
}
// MARK: - ValueTransformer Methods
extension TimeIntervalToStringTransformer {
    
    override public class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override public class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override public func transformedValue(_ value: Any?) -> Any? {
        var result: String?
        if let timeInterval: TimeInterval = value as? TimeInterval {
            let date: Date = Date(timeIntervalSince1970: timeInterval)
            result = self.dateFormatter.string(from: date)
        } else {
            assertionFailure("value must be of type TimeInterval")
        }
        return result
    }
}
