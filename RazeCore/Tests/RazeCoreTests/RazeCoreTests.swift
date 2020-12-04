import XCTest
@testable import RazeCore

final class RazeCoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RazeCore().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
