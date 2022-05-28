//
//  Coordinator.swift
//  engenious-challenge
//
//  Created by Sergii Tkachenko on 28.05.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func add(_ child: Coordinator)
    func remove(_ child: Coordinator)

    func start()
}

extension Coordinator {
    func add(_ child: Coordinator) {
        childCoordinators.append(child)
    }
    
    func remove(_ child: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}
