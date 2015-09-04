import Foundation

class StringCalculator {
    
    static let CommaSeparator = ","
    
    static func add(numbers:String)->Int{
        var result = 0
        for number in numbers.componentsSeparatedByString(StringCalculator.CommaSeparator) {
            result += number.numberOrZero
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