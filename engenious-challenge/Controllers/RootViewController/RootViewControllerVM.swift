//
//  RootViewControllerVM.swift.swift
//  engenious-challenge
//
//  Created by Alex Kogut on 05.06.2022.
//

import Foundation

protocol RootViewControllerVMDelegate: AnyObject {
    func reloadData()
}

final class RootViewControllerVM {
    
    // MARK: - Properties
    private var coordinator: RootCoordinator?
    private let repositoryService: RepositoryService = RepositoryService()
    private(set) var repoList: [RepoModel] = []
    
    let username: String = "Apple"
    var delegate: RootViewControllerVMDelegate?
    
    // MARK: - initializer
    init(coordinator: RootCoordinator?, delegate: RootViewControllerVMDelegate?) {
        self.coordinator = coordinator
        self.delegate = delegate
    }
    
    // MARK: - Internal Methods
    func handelData() {
        repositoryService.getUserRepos(username: username) { [weak self] response in
            DispatchQueue.main.async {
                self?.repoList = response
                self?.delegate?.reloadData()
            }
        }
    }
    
    func selected(indexPath: IndexPath) {
        print(repoList[indexPath.row])
    }
}
