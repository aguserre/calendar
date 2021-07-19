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
    
    func coordinateToCalendar(delegate: MainViewController, holidays: [HolidayModel]) {
        let calendarViewController = CalendarViewController(holidays: holidays)
        calendarViewController.delegate = delegate
        calendarViewController.coordinator = self
        pushWithModalAnimation(viewController: calendarViewController)
    }

}

extension MainCoordinator {
    func pushWithModalAnimation(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController.view.layer.add(transition, forKey: nil)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func popWithDismissAnimation() {
        let transition:CATransition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController.view.layer.add(transition, forKey: kCATransition)
        navigationController.popViewController(animated: false)
    }
}
