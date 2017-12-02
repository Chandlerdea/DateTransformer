//
//  DateToTimestampTransformer.swift
//  DateTransfomer
//
//  Created by Chandler De Angelis on 12/2/17.
//  Copyright © 2017 Chandler De Angelis. All rights reserved.
//

import UIKit

public final class DateToTimestampTransformer: ValueTransformer {

    // MARK: - Deinit
    
    deinit {
        if ValueTransformer(forName: .DateToTimestampTransformer) == nil {
            let newTransformer: DateToTimestampTransformer = DateToTimestampTransformer()
            ValueTransformer.setValueTransformer(newTransformer, forName: .DateToTimestampTransformer)
        }
    }
    
    // MARK: - Public Methods
    
    public func transformDate(_ date: Date) -> String? {
        return self.transformedValue(date) as? String
    }    
    
}
// MARK: - Private Methods
private extension DateToTimestampTransformer {
    
    func transformedRelativeTime(_ relativeDate: Date) -> String? {
        let calendar: Calendar = Calendar.current
        let comps: Set<Calendar.Component> = [.year, .month, .weekOfYear, .day, .hour, .minute, .second]
        let relativeComps: DateComponents = calendar.dateComponents(comps, from: relativeDate)
        let currentComps: DateComponents = calendar.dateComponents(comps, from: Date())
        let timeComps: DateComponents = calendar.dateComponents(comps, from: relativeComps, to: currentComps)
        let prefix: String
        let postFix: String
        if let years: Int = timeComps.year, years > 0 {
            prefix = String(describing: timeComps.year!)
            postFix = years > 1 ? NSLocalizedString("years ago", comment: "") : NSLocalizedString("year ago", comment: "")
        } else if let months: Int = timeComps.month, months > 0 {
            prefix = String(describing: timeComps.month!)
            postFix = months > 1 ? NSLocalizedString("months ago", comment: "") : NSLocalizedString("month ago", comment: "")
        } else if let weeks: Int = timeComps.weekOfYear, weeks > 0 {
            prefix = String(describing: timeComps.weekOfYear!)
            postFix = weeks > 1 ? NSLocalizedString("weeks ago", comment: "") : NSLocalizedString("week ago", comment: "")
        } else if let days: Int = timeComps.day, days > 0 {
            prefix = String(describing: timeComps.day!)
            postFix = days > 1 ? NSLocalizedString("days ago", comment: "") : NSLocalizedString("day ago", comment: "")
        } else if let hours: Int = timeComps.hour, hours > 0 {
            prefix = String(describing: timeComps.hour!)
            postFix = hours > 1 ? NSLocalizedString("hours ago", comment: "") : NSLocalizedString("hour ago", comment: "")
        } else if let minutes: Int = timeComps.minute, minutes > 0 {
            prefix = String(describing: timeComps.minute!)
            postFix = minutes > 1 ? NSLocalizedString("minutes ago", comment: "") : NSLocalizedString("minute ago", comment: "")
        } else if let seconds: Int = timeComps.second, seconds > 0 {
            return NSLocalizedString("Just now", comment: "")
        } else {
            return .none
        }
        return "\(prefix) \(postFix)"
    }
}
// MARK: - ValueTransformer Methods
extension DateToTimestampTransformer {
    
    override public class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override public class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override public func transformedValue(_ value: Any?) -> Any? {
        var result: String?
        if let date: Date = value as? Date {
            result = self.transformedRelativeTime(date)
        } else {
            assertionFailure("value must be of type Date")
        }
        return result
    }
}
