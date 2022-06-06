//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

final class RootViewController: UIViewController {
    
    // MARK: - Outlet
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let headerView = HeaderView()
    
    // MARK: - Properties
    var viewModel: RootViewControllerVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeader()
        setupTableView()
        setupRefresh()
        viewModel?.handelData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = viewModel?.username {
            title = "\(user)'s repos"
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Private Methods
    // MARK: - Table View
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.setEqualToConstraint(to: view)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
    }
    
    private func setupHeader() {
        headerView.setup(with: "Repositories")
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        headerView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.tableView.tableHeaderView = self.headerView
    }
    
    // MARK: - Refresh Control
    private func setupRefresh() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        viewModel?.handelData()
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension RootViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel?.repoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        cell.item = viewModel?.repoList[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RootViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selected(indexPath: indexPath)
    }
}

// MARK: - RootViewControllerVMDelegate
extension RootViewController: RootViewControllerVMDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
