import Foundation

class StringCalculator {
    
    static let CommaDelimiter = ","
    static let NewLineDelimiter = "\n"
    static let InitialDelimiter = "//"
    static let DefaultDelimiters = [CommaDelimiter, NewLineDelimiter, InitialDelimiter]
    
    static func add(numbers:String) throws ->Int {
        let delimiters = extractDelimiters(numbers)
        let numbersDivided = divideNumbers(delimiters,numbers:[numbers])
        let negativeNumbers = extractNegativeNumbers(numbersDivided)
        if negativeNumbers.count > 0 {
            throw StringCalculatorError.NegativeNotAllowed(negativeNumbers: negativeNumbers)
        }
        return numbersDivided.map { $0.numberOrZero }.filter { $0 <= 1000 }.reduce(0, combine: +)
    }
    
    static func extractDelimiters(numbers:String)->[String]{
        var delimiters = StringCalculator.DefaultDelimiters
        if hasCustomDelimiters(numbers) {
            delimiters.append(extractCustomDelimiter(numbers))
        }
        return delimiters
    }
    
    static func hasCustomDelimiters(numbers:String)->Bool {
        return numbers.hasPrefix(InitialDelimiter)
    }
    
    static func extractCustomDelimiter(numbers:String)->String{
        var startIndex = numbers.startIndex.advancedBy(InitialDelimiter.characters.count)
        var endIndex = numbers.rangeOfString(NewLineDelimiter, options: .BackwardsSearch)!.startIndex
        
        if numbers.containsString("[") && numbers.containsString("]") {
            startIndex = numbers.rangeOfString("[", options: .BackwardsSearch)!.startIndex.advancedBy(1)
            endIndex = numbers.rangeOfString("]", options: .BackwardsSearch)!.startIndex
        }

        return numbers[startIndex..<endIndex]
    }
    
    static func divideNumbers(delimiters:[String], numbers:[String], currentDelimiter:Int=0)->[String]{
        if currentDelimiter == delimiters.count {
            return numbers
        }
        return divideNumbers(delimiters, numbers: numbers.flatMap { $0.componentsSeparatedByString(delimiters[currentDelimiter]) }, currentDelimiter: currentDelimiter + 1)
    }
    
    static func extractNegativeNumbers(numbers:[String])->[Int]{
        return numbers.filter { $0.numberOrZero < 0 }.map { $0.numberOrZero }
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