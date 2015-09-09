import Foundation

class StringCalculator {
    
    static let CommaSeparator = ","
    static let NewLineSeparator = "\n"
    static let DefaultSeparators = [CommaSeparator, NewLineSeparator]
    
    static func add(numbers:String)->Int{
        var result = 0
        let separators = extractSeparators(numbers)
        let numbersDivided = divideNumbers(separators,numbers:[numbers])
        for number in numbersDivided {
            result += number.numberOrZero
        }
        return result
    }
    
    static func divideNumbers(separators:[String], numbers:[String], currentSeparator:Int=0)->[String]{
        if currentSeparator == separators.count {
            return numbers
        }
        return divideNumbers(separators, numbers: numbers.flatMap { $0.componentsSeparatedByString(separators[currentSeparator]) }, currentSeparator: currentSeparator + 1)
    }
    
    static func extractSeparators(numbers:String)->[String]{
        return StringCalculator.DefaultSeparators
    }
}

extension String {
    var numberOrZero:Int {
        let formatter = NSNumberFormatter()
        let number = formatter.numberFromString(self) as? Int
        return number ?? 0
    }
}