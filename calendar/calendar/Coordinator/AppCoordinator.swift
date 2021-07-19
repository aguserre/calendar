//
//  AppCoordinator.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 17/06/2021.
//

import UIKit


final class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = MainCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
}
