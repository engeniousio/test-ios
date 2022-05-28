//
//  ReposFlowCoordinator.swift
//  engenious-challenge
//
//  Created by Sergii Tkachenko on 28.05.2022.
//

import UIKit

final class ReposFlowCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let service = NetworkService()
        let reposViewModel = ReposViewModel(username: "Apple", service: service)
        let reposViewController = ReposViewController.instantiate(viewModel: reposViewModel)
        navigationController.viewControllers = [reposViewController]
    }
}
