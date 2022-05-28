//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

final class NetworkService {
    private let session: URLSession
    private let decoder = JSONDecoder()
    private var cancellable: AnyCancellable?
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchUserRepos(username: String) -> AnyPublisher<[Repo], Never> {
        guard let url = fullURL(username: username) else {
            return Just([]).eraseToAnyPublisher()
        }
        return makePublisher(url: url)
    }
    
    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void) {
        guard let _ = fullURL(username: username) else {
            return completion([])
        }
        self.cancellable = fetchUserRepos(username: username)
            .sink { repos in
                completion(repos)
        }
    }
    
    private func fullURL(username: String) -> URL? {
        return URL(string: "https://api.github.com/users/\(username)/repos")
    }
    
    private func makePublisher(url: URL) -> AnyPublisher<[Repo], Never> {
        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Repo].self, decoder: decoder)
            .catch { error in Just([]) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
