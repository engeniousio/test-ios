//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine
// MARK: - Config
fileprivate struct Config {
    static let gradientBackgroundColors = [
        UIColor(named: "backgroundLeft")?.cgColor ?? UIColor(red: 0.996, green: 0.996, blue: 0.996, alpha: 1).cgColor,
        UIColor(named: "backgroundRight")?.cgColor ?? UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
    ]
    static let gradientBackgroundLocations: [NSNumber] = [0, 1]
    static let gradientBackgroundStartPoint = CGPoint(x: 0.25, y: 0.5)
    static let gradientBackgroundEndPoint = CGPoint(x: 0.75, y: 0.5)
    
    static let sectionHeaderFont = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
    static let sectionHeaderColor = UIColor(named: "sectionHeader") ?? UIColor(red: 0, green: 0.417, blue: 0.716, alpha: 1)
    static let sectionHeaderText = "Repositories"
    static let sectionHeaderLeading: CGFloat = 20.5
    static let sectionHeaderHeight: CGFloat = 56.0
}

// MARK: - ViewController
final class RootViewController: UIViewController {
    let repositoryService: RepositoryService = RepositoryService()
    let userName: String = "Apple"
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    var repoList: [Repo] = []
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Config.gradientBackgroundColors
        gradientLayer.locations = Config.gradientBackgroundLocations
        gradientLayer.startPoint = Config.gradientBackgroundStartPoint
        gradientLayer.endPoint = Config.gradientBackgroundEndPoint
        return gradientLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        title = "\(userName)'s repos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        getRepos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.frame = view.bounds
    }
    
    private func getRepos() {
        repositoryService.getUserRepos(username: userName) { value in
            DispatchQueue.main.async {
                self.repoList = value
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - Delegate & DataSource
extension RootViewController: UITableViewDelegate, UITableViewDataSource {
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
