# DateTransformer
A small framwork for transforming Dates to Strings, and Strings to Dates

DateTransformer is a small library for transforming strings to dates, and dates to strings. The library uses a relativley unknown class in Foundation called [NSValueTransformer](http://nshipster.com/nsvaluetransformer/). This class is meant to be used to transform one value to another, and be subclassed to support transforming your types.

## Installation

### Carthage

Copy and paste the following into your `Cartfile`
```
github "Chandlerdea/DateTransformer"
```

### Manual

You can just drop DateTransformer.xcodeproj into your project and then add DateTransformer.framework to your app’s embedded frameworks.

## Use

There are 3 `NSValueTransformer` subclasses you can use, `StringToDateTransformer`, `TimeIntervalToStringTransformer` and `DateToTimestampTransformer`. 

### StringToDateTransformer

This class's forward transformation type is `Date`, and it allows reverse transformatio. That means that you can either take a `String` and transform it into a `Date`, or vice versa. This can be useful for taking string representaions of dates from an api and transform them into `Date` objects. By default, the class uses the format `yyyy-MM-dd'T'HH:mm:ssZ` to create dates. So if your api sends date strings in a different format, you'll have to pass the custom format to the date transformer.  Here's an example using a custom format:

```
let someApiData: [String: String] = ....
let createdAtString: String = someApiData["created_at"]!
let transformer: StringToDateTransformer = StringToDateTransformer()
let dateFormat: String = "EEEE, MMM d, yyyy"
if let createdAt: Date = transformer.transformString(createdAtString, dateFormat: dateFormat) {
  // do something with the date
}
```

You can also do reverse transformations, from `Date` to `String`. By default, the class uses the format `EEEE, MMM d, yyyy` to create the date strings. It is also important to note that the passed in date will have the system time zone applied by default. There is a `timeZone` argument that allows you to pass a custom time zone that will be applied to the date. Here's an example: 

```
let date: Date = Date(timeIntervalSince1970: 0)
let format: String = "MM/dd/yyyy"
let transformer: StringToDateTransformer = StringToDateTransformer()
if let result: String = transformer.transformDate(date, dateFormat: format) {
  // "01/01/1970"
}
```

### TimeIntervalToStringTransformer

`TimeIntervalToStringTransformer` transforms a `TimeInerval` to a `String`. A usecase would be if you were counting down from a date in the future to now, and you wanted to display the number of hours, minutes, and seconds to the user. The default format used by the class is `EEEE, MMM d, yyyy`. As before, it is important to note that the passed in timeInterval will have the system time zone applied by default. There is a `timeZone` argument that allows you to pass a custom time zone that will be applied to the date Here's an example:

```
let secondsToFutureDate: TimeInterval = ...
let dateFormat: String = "HH:mm:ss"
let transformer: TimeIntervalToStringTransformer = TimeIntervalToStringTransformer(dateFormat: dateFormat)
if let countdownString: String = transformer.transformTimeInterval(secondsToFutureDate) {
  // "01:01:01"
}

```

### DateToTimestampTransformer

`DateToTimestampTransformer` transforms a `Date` to a `String` timestamp. You would use this for showing a timestamp like `3 minutes ago`. Here's an example:

```
let dateInPast: Date = ...
let transformer: DateToTimestampTransformer = DateToTimestampTransformer()
if let timestamp: String = transformer.transformDate(dateInPast) {
  // "4 minutes ago"
 }
 ```

## Support

If you find any bugs, or have any critiques, please open a PR and I will fix them as soon as I can. And if you feel the need to add some more tests, you're more than welcome!
