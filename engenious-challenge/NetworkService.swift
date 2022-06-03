//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

// MARK: - Error
enum NetworkError: Error {
    case responceError
    case dataError
    case empty
    case parsing
}

// MARK: - Sevice
struct RepositoryService {
    static let urlString = "https://api.github.com/users/%@/repos"
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getUserRepos(username: String, completion: @escaping (Result<[Repo], NetworkError>) -> Void) {
        let formattedUrlString = String(format: RepositoryService.urlString, username)
        guard let url = URL(string: formattedUrlString) else {
            return completion(.failure(.empty))
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return completion(.failure(.responceError))
            }
            guard let data = data else {
                return completion(.failure(.dataError))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode([Repo].self, from: data)
                guard !response.isEmpty else {
                    return completion(.failure(.empty))
                }
                completion(.success(response))
            } catch {
                NSLog("Parsing JSON problem")
            }
        })
        
        task.resume()
    }
}
