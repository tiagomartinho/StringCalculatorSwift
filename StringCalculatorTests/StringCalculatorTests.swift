import XCTest
@testable import StringCalculator

class StringCalculatorTests: XCTestCase {
    func testEmptyStringReturnsZero() {
        assertCalculator("",expected: 0)
    }
    
    func testOneNumberReturnsNumber() {
        assertCalculator("1",expected: 1)
        assertCalculator("42",expected: 42)
    }
    
    func testAddingTwoNumbers() {
        assertCalculator("1,2",expected: 3)
    }
    
    func testAddingUnknownAmountOfNumbers() {
        assertCalculator("1,2,45,126,7",expected: 181)
    }
    
    func testAddingHandleNewLinesDelimiters() {
        assertCalculator("1\n2,3",expected: 6)
    }
    
    func testSupportDifferentDelimeters(){
        assertCalculator("//;\n1;2",expected: 3)
    }
    
    func testAddWithNegativeNumbersThrowsException(){
        XCTAssertEqual(assertCalculator("-1,2",expected: 0),[-1])
    }
    
    func testAddWithoutNegativeNumbersDoesNotThrowsException(){
        XCTAssertEqual(assertCalculator("1,2",expected: 3),[])
    }
    
    func testNumbersGreaterThanOneThousandGetIgnored(){
        assertCalculator("1001,2",expected: 2)
    }
    
    func testSupportDelimetersWithMultipleLength(){
        assertCalculator("//[***]\n1***2***3",expected: 6)
    }
    
    func testSupportMultipleCustomDelimeters(){
        assertCalculator("//[*][%]\n1*2%3",expected: 6)
    }
    
    func testSupportMultipleCustomDelimetersWithMultipleLength(){
        assertCalculator("//[***][%]\n1***2%3",expected: 6)
    }
    
    func assertCalculator(input:String,expected:Int)->[Int]{
        do {
            let calculator = StringCalculator(numbers: input)
            let result = try calculator.add()
            XCTAssertEqual(result, expected)
        } catch StringCalculatorError.NegativeNotAllowed(let negativeNumbers){
            return negativeNumbers
        }
        catch {
        }
        return [Int]()
    }
}
