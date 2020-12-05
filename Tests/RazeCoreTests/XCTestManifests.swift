import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RazeColorTests.allTests),
        testCase(RazeNetworkingTests.allTests)
    ]
}
#endif
