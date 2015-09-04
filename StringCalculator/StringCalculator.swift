import Foundation

class StringCalculator {
    static func add(numbers:String)->Int{
        let formatter = NSNumberFormatter()
        var result = 0
        for number in numbers.componentsSeparatedByString(",") {
            result += Int(formatter.numberFromString(number) ?? 0)
        }
        return result
    }
}