//
//  SceneDelegate.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        coordinator = appCoordinator
        coordinator?.start()
    }
}
