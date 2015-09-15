import Foundation

class StringCalculator {
    
    static let CommaDelimiter = ","
    static let NewLineDelimiter = "\n"
    static let InitialDelimiter = "//"
    static let DefaultDelimiters = [CommaDelimiter, NewLineDelimiter, InitialDelimiter]
    
    static func add(numbers:String) throws ->Int {
        let delimiters = extractDelimiters(numbers)
        let numbersDivided = divideNumbers(delimiters,numbers:[numbers])
        var negativeNumbers = [Int]()
        for number in numbersDivided {
            if number.numberOrZero < 0 {
                negativeNumbers.append(number.numberOrZero)
            }
        }
        if negativeNumbers.count > 0 {
            throw StringCalculatorError.NegativeNotAllowed(negativeNumbers: negativeNumbers)
        }
        return numbersDivided.flatMap { $0.numberOrZero <= 1000 ? $0.numberOrZero : 0 }.reduce(0, combine: +)
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

enum StringCalculatorError: ErrorType {
    case NegativeNotAllowed(negativeNumbers: [Int])
}