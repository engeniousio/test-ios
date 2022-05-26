//
// Created by Agapov Oleg on 5/26/22.
//

import Foundation
import Combine

protocol DetailViewModeling {
    @Published var repoList: [RepoDTO]
    func getRepos()
}

class RootViewModel: DetailViewModeling {

    @Published var repoList = [RepoDTO]()

    private let repositoryService: RepositoryServicing
    private let username: String = "Apple"

    private var cancelable = AnyCancellable?

    init(repositoryService: RepositoryServicing = RepositoryService()) {
        self.repositoryService = repositoryService
    }

    func getRepos() {
        cancelable = repositoryService.publishUserRepos(username: username)
                .assign(to: repoList)
    }

}
