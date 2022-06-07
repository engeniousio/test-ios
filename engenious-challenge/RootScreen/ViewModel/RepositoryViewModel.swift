    //
    //  RepositoryViewModel.swift
    //  engenious-challenge
    //
    //  Created by Anastasia Kholod on 07.06.2022.
    //

import Foundation

class RepositoryViewModel: NSObject {
    let username: String = "Apple"
    var reloadTableView: (() -> Void)?
    
    var repoCellViewModels = [RepositoryCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    private var repositoryService: RepositoryService = RepositoryService()
    
    init(repositoryService: RepositoryService = RepositoryService()) {
        self.repositoryService = repositoryService
    }
    
    func getRepositories() {
        repositoryService.getUserRepos(username: username) { repos in
            DispatchQueue.main.async {
                self.fetchData(repositories: repos)
            }
        }
    }
    
    func fetchData(repositories: [RepositoryModel]) {
        var vms = [RepositoryCellViewModel]()
        for repo in repositories {
            vms.append(createCellModel(repository: repo))
        }
        repoCellViewModels = vms
    }
    
    func createCellModel(repository: RepositoryModel) -> RepositoryCellViewModel {
        let name = repository.name
        let description = repository.description
        let url = repository.url
        
        return RepositoryCellViewModel(name: name, description: description, url: url)
    }
}
