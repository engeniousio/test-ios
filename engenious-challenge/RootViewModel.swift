//
//  RootViewModel.swift
//  engenious-challenge
//
//  Created by Anton Bugera on 03.06.2022.
//

import UIKit

// MARK: - Config
fileprivate struct Config {
    static let sectionHeaderFont = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
    static let sectionHeaderColor = UIColor(named: "sectionHeader") ?? UIColor(red: 0, green: 0.417, blue: 0.716, alpha: 1)
    static let sectionHeaderText = "Repositories"
    static let sectionHeaderLeading: CGFloat = 20.5
    static let sectionHeaderHeight: CGFloat = 56.0
}

// MARK: - Protocol
protocol RootViewModelProtocol: UITableViewDelegate, UITableViewDataSource {
    var title: String { get }
    var reposUpdated: (() -> Void)? { get set }
    func getRepos()
}

// MARK: - View Model
class RootViewModel: NSObject, RootViewModelProtocol {
    var reposUpdated: (() -> Void)?
    lazy var title: String = {
        "\(userName)'s repos"
    }()
    
    private let repositoryService: RepositoryService = RepositoryService()
    private let userName: String = "Apple"
    
    private var repoList: [Repo] = []
    
    func getRepos() {
        repositoryService.getUserRepos(username: userName) { result in
            switch result {
            case .failure(let error):
                NSLog("The error: %@", error.localizedDescription)
                return
            case .success(let repositories):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.repoList = repositories
                    self.reposUpdated?()
                }
            }
        }
    }
}

//MARK: - Delegate & DataSource
extension RootViewModel {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        let repo = repoList[indexPath.row]
        cell.titleLabel.text = repo.name
        cell.descriptionLabel.text = repo.description
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(origin: CGPoint(x: Config.sectionHeaderLeading, y: 0),
                           size: CGSize(width: tableView.bounds.width, height: Config.sectionHeaderHeight))
        
        let label = UILabel(frame: frame)
        label.font = Config.sectionHeaderFont
        label.textColor = Config.sectionHeaderColor
        label.text = Config.sectionHeaderText
        
        let view = UIView()
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Config.sectionHeaderHeight
    }
}
