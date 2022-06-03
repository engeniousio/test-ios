//
//  engenious_challengeTests.swift
//  engenious-challengeTests
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import XCTest
@testable import engenious_challenge

class engenious_challengeTests: XCTestCase {
    var networkService: RepositoryService!
    var expectation: XCTestExpectation!
    let successUrl = URL(string: String(format: RepositoryService.urlString, "success"))!
    let failureUrl = URL(string: String(format: RepositoryService.urlString, "failure"))!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        networkService = RepositoryService(session: urlSession)
        expectation = expectation(description: "RepositoryService Expectation")
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        MockURLProtocol.requestHandler = nil
    }
    
    func testSuccessResponce() throws {
        let successResponseJson = """
                                 [{
                                    "name":"Some Repo",
                                    "description":"some description",
                                    "url":"some url"
                                 }]
                                """
        let data = successResponseJson.data(using: .utf8)
        MockURLProtocol.requestHandler = { [weak self] request in
            guard let self = self else {
                fatalError()
            }
            guard let url = request.url, url == self.successUrl else {
                throw NetworkError.responceError
            }
            guard let response = HTTPURLResponse(url: self.successUrl, statusCode: 200, httpVersion: nil, headerFields: nil) else {
                throw NetworkError.responceError
            }
            return (response, data)
        }
        networkService.getUserRepos(username: "success") { [weak self] result in
            switch result {
            case .failure(let error):
                XCTFail("testSuccessResponce is failed with error: \(error.localizedDescription)")
            case .success(let repositories):
                XCTAssertEqual(repositories.count, 1)
                let repo = repositories.first
                XCTAssertEqual(repo?.name, "Some Repo")
                XCTAssertEqual(repo?.description, "some description")
                XCTAssertEqual(repo?.url, "some url")
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testResponseFailureResponce() {
        MockURLProtocol.requestHandler = { [weak self] request in
            guard let self = self else {
                fatalError()
            }
            if let url = request.url, url == self.failureUrl {
                throw NetworkError.responceError
            }
            return (HTTPURLResponse(), nil)
        }
        networkService.getUserRepos(username: "failure") { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.responceError)
            case .success(_):
                XCTFail("testURLFailureResponce is failed.")
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
