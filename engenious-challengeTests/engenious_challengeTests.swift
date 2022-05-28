//
//  engenious_challengeTests.swift
//  engenious-challengeTests
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import XCTest
@testable import engenious_challenge

class engenious_challengeTests: XCTestCase {
    
    var session: URLSession!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockProtocol.self]
        session = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {}

    func testGetRepos() throws {
        var service = NetworkService(session: session)
        let repos = [Repo(name: "Repo name", description: "Repo description", url: "https://example.com/repo1/")]
        let data = try JSONEncoder().encode(repos)
        MockProtocol.requestHandler = { request in
            return (HTTPURLResponse(), data)
        }
        let expectation = XCTestExpectation(description: "response")
        service.getUserRepos(username: "test", completion: { repos in
            let repo = repos[0]
            XCTAssertEqual(repo.name, "Repo name")
            XCTAssertEqual(repo.description, "Repo description")
            XCTAssertEqual(repo.url, "https://example.com/repo1/")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
}
