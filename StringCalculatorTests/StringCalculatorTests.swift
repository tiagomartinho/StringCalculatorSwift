import XCTest
@testable import StringCalculator

class StringCalculatorTests: XCTestCase {
    func testEmptyStringReturnsZero() {
        XCTAssertEqual(StringCalculator.add(""), 0)
    }
    
    func testOneNumberReturnsNumber() {
        XCTAssertEqual(StringCalculator.add("1"), 1)
        XCTAssertEqual(StringCalculator.add("42"), 42)
    }
    
    func testAddingTwoNumbers() {
        XCTAssertEqual(StringCalculator.add("1,2"), 3)
    }
    
    func testAddingUnknownAmountOfNumbers() {
        XCTAssertEqual(StringCalculator.add("1,2,45,126,7"), 181)
    }
}
