import XCTest
@testable import StringCalculator

class StringCalculatorTests: XCTestCase {
    func testEmptyStringReturnsZero() throws {
        try assertCalculator("",expected: 0)
    }
    
    func testOneNumberReturnsNumber() throws {
        try assertCalculator("1",expected: 1)
        try assertCalculator("42",expected: 42)
    }
    
    func testAddingTwoNumbers() throws {
        try assertCalculator("1,2",expected: 3)
    }
    
    func testAddingUnknownAmountOfNumbers() throws {
        try assertCalculator("1,2,45,126,7",expected: 181)
    }
    
    func testAddingHandleNewLinesDelimiters() throws {
        try assertCalculator("1\n2,3",expected: 6)
    }
    
    func testSupportDifferentDelimeters() throws {
        try assertCalculator("//;\n1;2",expected: 3)
    }
    
    func testAddWithNegativeNumbersThrowsException() throws {
        let result = try assertCalculator("-1,2",expected: 3)
        XCTAssertEqual(result,[-1])
    }
    
    func testAddWithoutNegativeNumbersDoesNotThrowsException() throws {
        let result = try assertCalculator("1,2",expected: 3)
        XCTAssertEqual(result,[])
    }
    
    func assertCalculator(input:String,expected:Int) throws ->[Int]{
        do {
            let result = try StringCalculator.add(input)
            XCTAssertEqual(result, expected)
        } catch StringCalculatorError.NegativeNotAllowed(let negativeNumbers){
            return negativeNumbers
        }
        return [Int]()
    }
}
