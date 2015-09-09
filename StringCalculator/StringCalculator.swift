import Foundation

class StringCalculator {
    
    static let CommaDelimiter = ","
    static let NewLineDelimiter = "\n"
    static let InitialDelimiter = "//"
    static let DefaultDelimiters = [CommaDelimiter, NewLineDelimiter, InitialDelimiter]
    
    static func add(numbers:String)->Int{
        let delimiters = extractDelimiters(numbers)
        let numbersDivided = divideNumbers(delimiters,numbers:[numbers])
        return numbersDivided.flatMap { $0.numberOrZero }.reduce(0, combine: +)
    }
    
    static func divideNumbers(delimiters:[String], numbers:[String], currentDelimiter:Int=0)->[String]{
        if currentDelimiter == delimiters.count {
            return numbers
        }
        return divideNumbers(delimiters, numbers: numbers.flatMap { $0.componentsSeparatedByString(delimiters[currentDelimiter]) }, currentDelimiter: currentDelimiter + 1)
    }
    
    static func extractDelimiters(numbers:String)->[String]{
        var delimiters = StringCalculator.DefaultDelimiters
        if numbers.hasPrefix("//") {
            let delimiter = numbers.substringWithRange(Range<String.Index>(start: numbers.startIndex.advancedBy(2), end: numbers.startIndex.advancedBy(3)))
            delimiters.append(delimiter)
        }
        return delimiters
    }
}

extension String {
    var numberOrZero:Int {
        let formatter = NSNumberFormatter()
        let number = formatter.numberFromString(self) as? Int
        return number ?? 0
    }
}