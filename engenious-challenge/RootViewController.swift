//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

class RootViewController: UIViewController {

    private let viewModel: DetailViewModeling
    private var cancelable = AnyCancellable?

    private let tv = UITableView()

    init(viewModel: DetailViewModeling) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()

        bind()
        getRepos()
    }

    private func setupLayout() {
        tv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tv)
        tv.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tv.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tv.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupViews() {
        view.backgroundColor = .white
        title = "\(username)'s repos"
        navigationController?.navigationBar.prefersLargeTitles = true

        tv.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
    }

    private func bind() {
        viewModel.$repoList.bind(subscriber:
            tv.rowsSubscriber(cellIdentifier: String(describing: RepoTableViewCell.self),
                    cellType: RepoTableViewCell.self,
                    cellConfig: { cell, indexPath, person in
                        guard let cell = cell as? RepoTableViewCell else { return }
                        cell.title = repo.name
                        cell.text = repo.description
                    }
            )
        )
    }

}

