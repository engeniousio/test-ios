//
//  ReposViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

final class ReposViewController: UIViewController {
    
    var viewModel: ReposViewModel!
    private var cancellable: Set<AnyCancellable> = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 32.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        return tableView
    }()
    
    static func instantiate(viewModel: ReposViewModel) -> Self {
        let viewController = Self.init()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        binding()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: viewModel.contentBackgroundColor)
        title = viewModel.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func binding() {
        viewModel.repos.sink { [unowned self] _ in
            self.tableView.reloadData()
        }
        .store(in: &cancellable)
    }
}

extension ReposViewController: UITableViewDelegate {}

extension ReposViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
        let repo = viewModel.repoForRowAt(indexPath: indexPath)
        cell.nameLabel.text = repo.0
        cell.descriptionLabel.text = repo.1
        cell.nameLabel.textColor = UIColor(hex: viewModel.cellTitleTextColor)
        cell.descriptionLabel.textColor = UIColor(hex: viewModel.cellDetailTextColor)
        cell.stackView.backgroundColor = UIColor(hex: viewModel.cellBackgroundColor)
        cell.backgroundColor = UIColor(hex: viewModel.contentBackgroundColor)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ReposHeaderView()
        headerView.backgroundColor = UIColor(hex: viewModel.contentBackgroundColor)
        headerView.headerLabel.text = viewModel.sectionTitle
        headerView.headerLabel.textColor = UIColor(hex: viewModel.cellHeaderTextColor)
        return headerView
    }
}
