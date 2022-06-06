//
//  RootCoordinator.swift
//  engenious-challenge
//
//  Created by Alex Kogut on 06.06.2022.
//

import UIKit

final class RootCoordinator: BaseCoordinator {
    
    func start() {
        let controller = RootViewController()
        controller.viewModel = .init(coordinator: self, delegate: controller)
        navigationController?.setViewControllers([controller], animated: false)
    }
}
