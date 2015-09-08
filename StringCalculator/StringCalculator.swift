import Foundation

class StringCalculator {
    
    static let CommaSeparator = ","
    static let NewLineSeparator = "\n"
    
    static func add(numbers:String)->Int{
        var result = 0
        let numbersDivided = divideStrings(divideStrings([numbers],WithSeparator: StringCalculator.CommaSeparator),WithSeparator: StringCalculator.NewLineSeparator)
        for number in numbersDivided {
            result += number.numberOrZero
        }
        return result
    }
    
    static func divideStrings(strings:[String],WithSeparator separator:String)->[String]{
        var result = [String]()
        for value in strings {
            result += value.componentsSeparatedByString(separator)
        }
        return result
    }
}

extension String {
    var numberOrZero:Int {
        let formatter = NSNumberFormatter()
        let number = formatter.numberFromString(self) as? Int
        return number ?? 0
    }
}