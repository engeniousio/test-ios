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
}

// MARK: - ViewController
final class RootViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private var viewModel: RootViewModelProtocol
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Config.gradientBackgroundColors
        gradientLayer.locations = Config.gradientBackgroundLocations
        gradientLayer.startPoint = Config.gradientBackgroundStartPoint
        gradientLayer.endPoint = Config.gradientBackgroundEndPoint
        return gradientLayer
    }()
    
    init(viewModel: RootViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(tableView)
        
        setNavigationController()
        setTableView()
        setConstraints()
        setBindings()
        
        viewModel.getRepos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.frame = view.bounds
    }
    
    private func setNavigationController() {
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
    }
    
    private func setBindings() {
        viewModel.reposUpdated = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func setConstraints() {
        let tableViewConstraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
}
