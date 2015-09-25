import XCTest

class StringCalculatorUITests: XCTestCase {
    
    let application = XCUIApplication()
    
    var calculateButton: XCUIElement?
    var stringInputTextField: XCUIElement?
    var resultInformationLabel: XCUIElement?
    var resultLabel: XCUIElement?
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        application.launch()
        
        calculateButton = application.buttons["calculate"]
        stringInputTextField = application.textFields["stringInput"]
        resultInformationLabel = application.staticTexts.elementMatchingType(.Any, identifier: "resultLabel")
        resultLabel = application.staticTexts.elementMatchingType(.Any, identifier: "result")
    }
    
    func testCheckUIAndIsAccessible() {
        XCTAssert(calculateButton?.exists ?? false)
        XCTAssert(stringInputTextField?.exists ?? false)
        XCTAssert(resultInformationLabel?.exists ?? false)
        XCTAssert(resultLabel?.exists ?? false)
        XCTAssertEqual("",stringInputTextField?.value as? String)
        XCTAssertEqual("",resultLabel?.label)
    }
}
