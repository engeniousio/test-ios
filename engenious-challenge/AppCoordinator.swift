//
//  AppCoordinator.swift
//  engenious-challenge
//
//  Created by Sergii Tkachenko on 28.05.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        toRepos()
        
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate = scene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }

    private func toRepos() {
        // clearing
        navigationController.viewControllers.removeAll()
        childCoordinators.removeAll()
        
        let authCoordinator = ReposFlowCoordinator(navigationController: navigationController)
        add(authCoordinator)
        authCoordinator.start()
    }
}
