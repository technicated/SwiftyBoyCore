import XCTest
@testable import SwiftyBoyCore

final class SwiftyBoyCoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftyBoyCore().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
