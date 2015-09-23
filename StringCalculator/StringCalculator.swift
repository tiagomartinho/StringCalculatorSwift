import Foundation

class StringCalculator {
    
    private let CommaDelimiter = ","
    private let NewLineDelimiter = "\n"
    private let InitialDelimiter = "//"
    private let CustomDelimiterStart = "["
    private let CustomDelimiterEnd = "]"
    
    private let DefaultDelimiters: [String]
    private let numbers:String
    
    init(numbers:String){
        self.numbers = numbers
        self.DefaultDelimiters = [CommaDelimiter, NewLineDelimiter, InitialDelimiter]
    }
    
    func add() throws ->Int {
        let delimiters = extractDelimiters()
        let numbersDivided = divide([numbers], WithDelimiters: delimiters)
        let negativeNumbers = extractNegativeNumbers(numbersDivided)
        if negativeNumbers.count > 0 {
            throw StringCalculatorError.NegativeNotAllowed(negativeNumbers: negativeNumbers)
        }
        return numbersDivided.map { $0.numberOrZero }.filter { $0 <= 1000 }.reduce(0, combine: +)
    }
    
    private func extractDelimiters()->[String]{
        if hasCustomDelimiters {
            return extractCustomDelimiters() + DefaultDelimiters
        }
        return DefaultDelimiters
    }
    
    private var hasCustomDelimiters:Bool {
        return numbers.hasPrefix(InitialDelimiter)
    }
    
    private func extractCustomDelimiters()->[String] {
        if hasMultipleDelimiters {
            return extractMultipleDelimiters()
        }
        return [customDelimiters]
    }
    
    private var hasMultipleDelimiters:Bool {
        return numbers.containsString(CustomDelimiterStart) && numbers.containsString(CustomDelimiterEnd)
    }
    
    private func extractMultipleDelimiters()->[String] {
        return divide([customDelimiters], WithDelimiters: [CustomDelimiterStart, CustomDelimiterEnd])
    }
    
    private var customDelimiters:String {
        return numbers[indexAfterInitialDelimiter..<indexBeforeFinalDelimiter]
    }
    
    private var indexAfterInitialDelimiter:String.Index {
        return numbers.startIndex.advancedBy(InitialDelimiter.characters.count)
    }
    
    private var indexBeforeFinalDelimiter:String.Index {
        return numbers.rangeOfString(NewLineDelimiter, options: .BackwardsSearch)!.startIndex
    }
    
    private func divide(numbers:[String], WithDelimiters delimiters:[String], currentDelimiter:Int=0)->[String] {
        if currentDelimiter == delimiters.count {
            return numbers
        }
        return divide(numbers.flatMap { $0.componentsSeparatedByString(delimiters[currentDelimiter]) }, WithDelimiters: delimiters, currentDelimiter: currentDelimiter + 1)
    }
    
    private func extractNegativeNumbers(numbers:[String])->[Int]{
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