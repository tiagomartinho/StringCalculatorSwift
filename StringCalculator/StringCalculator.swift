import Foundation

class StringCalculator {
    
    static let CommaDelimiter = ","
    static let NewLineDelimiter = "\n"
    static let DefaultDelimiters = [CommaDelimiter, NewLineDelimiter]
    
    static func add(numbers:String)->Int{
        var result = 0
        let delimiters = extractDelimiters(numbers)
        let numbersDivided = divideNumbers(delimiters,numbers:[numbers])
        for number in numbersDivided {
            result += number.numberOrZero
        }
        return result
    }
    
    static func divideNumbers(delimiters:[String], numbers:[String], currentDelimiter:Int=0)->[String]{
        if currentDelimiter == delimiters.count {
            return numbers
        }
        return divideNumbers(delimiters, numbers: numbers.flatMap { $0.componentsSeparatedByString(delimiters[currentDelimiter]) }, currentDelimiter: currentDelimiter + 1)
    }
    
    static func extractDelimiters(numbers:String)->[String]{
        return StringCalculator.DefaultDelimiters
    }
}

extension String {
    var numberOrZero:Int {
        let formatter = NSNumberFormatter()
        let number = formatter.numberFromString(self) as? Int
        return number ?? 0
    }
}