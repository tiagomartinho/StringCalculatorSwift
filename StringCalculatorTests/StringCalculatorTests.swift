import XCTest
@testable import StringCalculator

class StringCalculatorTests: XCTestCase {
    func testEmptyStringReturnsZero() {
        XCTAssertEqual(StringCalculator.add(""), 0)
    }
}
