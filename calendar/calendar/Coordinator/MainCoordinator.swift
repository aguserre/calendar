//
//  MainCoordinator.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 17/06/2021.
//

import UIKit


final class MainCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = MainViewController(with: MainViewModel())
        startViewController.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(startViewController, animated: true)
    }

}
