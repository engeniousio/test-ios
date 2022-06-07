    //
    //  RepositoryViewController.swift
    //  engenious-challenge
    //
    //  Created by Abdullah Atkaev on 20.05.2022.
    //

import UIKit
import Combine

class RepositoryViewController: UIViewController {
    private let mainView = RepositoryView()
    private lazy var viewModel = {
        RepositoryViewModel()
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        mainView.titleLabel.text = "\(viewModel.username)"
        initViewModel()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))
    }
    
    func initViewModel() {
        viewModel.getRepositories()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.mainView.tableView.reloadData()
            }
        }
    }
}

extension RepositoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self)) as? RepositoryTableViewCell else { return UITableViewCell() }
        cell.item = viewModel.repoCellViewModels[indexPath.row]
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: mainView.tableView.bounds.size.width, height: 50))
        let title = UILabel.init(frame: CGRect(x: 15, y: 13, width: mainView.tableView.bounds.size.width - 10, height: 24))
        if section == 0 {
            title.text = "Repositories"
        }
        headerView.backgroundColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = UIColor(named: "blue")
        headerView.addSubview(title)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
