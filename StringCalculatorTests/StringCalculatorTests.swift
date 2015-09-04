import XCTest
@testable import StringCalculator

class StringCalculatorTests: XCTestCase {
    func testEmptyStringReturnsZero() {
        XCTAssertEqual(StringCalculator.add(""), 0)
    }
    
    func testOneDigitStringReturnsDigit() {
        XCTAssertEqual(StringCalculator.add("1"), 1)
    }
}
