//
//  RazeNetworkingTest.swift
//  RazeCoreTests
//
//  Created by Vladimir Flores on 04/12/20.
//

import XCTest
@testable import RazeCore

class NetworkSessionMock: NetworkSession {

    var data: Data?
    var error: Error?

    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }

    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}

struct MockData: Codable, Equatable {

    var id: Int
    var name: String
}

final class RazeNetworkingTest: XCTestCase {

    func testLoadDataCall() {
        let manager = RazeCore.Networking.Manager()
        let session = NetworkSessionMock()
        manager.session = session
        let expectation = XCTestExpectation(description: "Called for data")
        let data = Data([0, 1, 0, 1])
        session.data = data
        let url = URL(fileURLWithPath: "url")
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                XCTAssertEqual(data, returnedData, "Returned data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "Error forming error result")
            }
        }
        wait(for: [expectation], timeout: 5)
    }

    func testSendDataCall() {
        let session = NetworkSessionMock()
        let manager = RazeCore.Networking.Manager()
        let sampleObject = MockData(id: 1, name: "John")
        let data = try? JSONEncoder().encode(sampleObject)
        session.data = data
        manager.session = session
        let url = URL(fileURLWithPath: "url")
        let expectation = XCTestExpectation(description: "Send data")

        manager.sendData(to: url, body: sampleObject) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                let returnedObject = try? JSONDecoder().decode(MockData.self, from: returnedData)
                XCTAssertEqual(returnedObject, sampleObject)
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "Error forming error reuslt")
            }
        }

        wait(for: [expectation], timeout: 5)
    }

    static var allTests = [
        ("testLoadDataCall", testLoadDataCall)
    ]
}
