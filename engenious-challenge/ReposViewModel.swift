//
//  ReposViewModel.swift
//  engenious-challenge
//
//  Created by Sergii Tkachenko on 28.05.2022.
//

import Foundation
import Combine

final class ReposViewModel {
    private var username: String
    private var service: NetworkService
    private(set) var cancellable = Set<AnyCancellable>([])
    private(set) var repos = CurrentValueSubject<[Repo], Never>([Repo]())
    
    init(username: String, service: NetworkService) {
        self.username = username
        self.service = service
        service.fetchUserRepos(username: username)
            .assign(to: \.repos.value, on: self)
            .store(in: &self.cancellable)
    }
    
    var navigationTitle: String {
        return "\(username.capitalized)'s repos"
    }
    
    var sectionTitle: String {
        return "Repositories"
    }
    
    // MARK: Colors
    var contentBackgroundColor: String {
        return "#ffffff"
    }
    
    var cellBackgroundColor: String {
        return "#E2F0FD"
    }
    
    var cellHeaderTextColor: String {
        return "#266AB4"
    }
    
    var cellTitleTextColor: String {
        return "#266AB4"
    }
    
    var cellDetailTextColor: String {
        return "#18487A"
    }
    
    // MARK: Table
    func numberOfRowsInSection() -> Int {
        return repos.value.count
    }
    
    func repoForRowAt(indexPath: IndexPath) -> (String, String?) {
        let repo = repos.value[indexPath.row]
        return (repo.name, repo.description)
    }
}
