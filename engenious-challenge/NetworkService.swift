//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

protocol RepositoryServicing {
    func getUserRepos(username: String, completion: @escaping ([RepoDTO]) -> Void)
    func publishUserRepos(username: String) -> AnyPublisher<[RepoDTO], Never>
}

class RepositoryService: RepositoryServicing {

    private var cancellable: AnyCancellable?

    func publishUserRepos(username: String) -> AnyPublisher<[RepoDTO], Never> {
        guard let request = createRequest(username: username) else { return Just([]).eraseToAnyPublisher() }
        let task = URLSession.shared.dataTaskPublisher(for: request)
        return task
                .tryMap { result in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode([RepoDTO].self, from: data)
                    return response
                }
                .catchError(Just([]))
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }

    func getUserRepos(username: String,
                      completion: @escaping ([RepoDTO]) -> Void) {
        cancelable = publishUserRepos.sink() { repos in
            completion(repos)
        }
    }

    private func createRequest(username: String) -> URLRequest? {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            return nil
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        return request
    }

}
