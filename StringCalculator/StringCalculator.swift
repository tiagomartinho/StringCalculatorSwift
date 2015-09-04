import Foundation

class StringCalculator {
    static func add(numbers:String)->Int{
        let formatter = NSNumberFormatter()
        return Int(formatter.numberFromString(numbers) ?? 0)
    }
}