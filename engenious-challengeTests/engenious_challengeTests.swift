//
//  engenious_challengeTests.swift
//  engenious-challengeTests
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import XCTest
import Combine
@testable import engenious_challenge

class RepositoryMock: RepositoryServicing {

    let mock = [RepoDTO(name: "Repo", description: "Just Repo", url: "https://google.com")]

    func getUserRepos(username: String, completion: @escaping ([RepoDTO]) -> Void) {
        completion(mock)
    }
    func publishUserRepos(username: String) -> AnyPublisher<[RepoDTO], Never> {
        return Just(mock)
    }

}

class engenious_challengeTests: XCTestCase {

    var vm: RootViewModel!

    override func setUpWithError() throws {
        vm = RootViewModel(repositoryService: RepositoryMock())
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func testGetRepos() throws {
        let expectation = self.expectation(description: "recieved repo")
        let cancellable = vm.$repoList.sink() { value in
            XCAssert(value.count == RepositoryMock().count, "different values")
            expectation.fullfil()
        }
        vm.getRepos()
        waitForExpectations(timeout: 0.3, handler: nil)
    }


}
