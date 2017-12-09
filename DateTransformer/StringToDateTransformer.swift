//
//  DateTransformer.swift
//  DateTransformer
//
//  Created by Chandler De Angelis on 11/30/17.
//

import Foundation

public final class StringToDateTransformer: ValueTransformer {

    // MARK: - Properties

    public static let defaultStringToDateFormat:    String      = "yyyy-MM-dd'T'HH:mm:ssZ"
    public static let defaultDateFormat:            String      = "EEEE, MMM d, yyyy"

    private lazy var dateFormatter: DateFormatter = DateFormatter()
    
    /**
    Takes a string representation of a date, and returns an optional date. This is the forward transform.
    - parameter string: The string representation of the date
    - parameter dateFormat: The date format string, so the internal `DateFormatter` is able to read the date string. Defaults to `yyyy-MM-dd'T'HH:mm:ssZ`
    - parameter timeZone: The timezone that the date string is in. The default is UTC, because `Date` objects are represented in UTC.
    - returns: An optional `Date`
    */
    public func transformString(_ string: String, dateFormat: String = StringToDateTransformer.defaultStringToDateFormat, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) -> Date? {
        self.dateFormatter.dateFormat = dateFormat
        self.dateFormatter.timeZone = timeZone
        return self.transformedValue(string) as? Date
    }
    
    /**
     Takes a `Date`, and returns a string representation of that date. This is the reverse transform.
     - parameter date: The date that will be transformed into a string
     - parameter dateFormat: The date format string, which represents how the `Date` will be displayed. Defaults to `StringToDateTransformer.defaultDateFormat`
     - parameter timeZone: A `TimeZone` that will be applied the the `Date`. Defaults to UTC.
     - returns: An optional `String`
     */
    public func transformDate(_ date: Date, dateFormat: String = StringToDateTransformer.defaultDateFormat, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) -> String? {
        self.dateFormatter.dateFormat = dateFormat
        self.dateFormatter.timeZone = timeZone
        return self.reverseTransformedValue(date) as? String
    }
}

// MARK: - ValueTransformer Methods
extension StringToDateTransformer {

    override public class func allowsReverseTransformation() -> Bool {
        return true
    }

    override public class func transformedValueClass() -> AnyClass {
        return NSDate.self
    }

    override public func transformedValue(_ value: Any?) -> Any? {
        var result: AnyObject?
        if let string = value as? String {
            var date: AnyObject?
            var canParse: Bool
            do {
                try self.dateFormatter.getObjectValue(&date, for: string, range: nil)
                canParse = true
            } catch {
                canParse = false
            }
            if canParse {
                result = date as? Date as AnyObject?
            }
        } else {
            assertionFailure("value needs to be a string")
        }
        return result
    }
    
    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        var result: AnyObject?
        if let date: Date = value as? Date {
            result = self.dateFormatter.string(from: date) as AnyObject?
        } else {
            assertionFailure("value must be of type NSDate")
        }
        return result
    }
}

