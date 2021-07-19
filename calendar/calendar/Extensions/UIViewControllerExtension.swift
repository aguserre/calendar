//
//  UIViewControllerExtension.swift
//  calendar
//
//  Created by Agustin Errecalde on 19/07/2021.
//

import UIKit

extension UIViewController {
    func generateSuccessImpact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func generateErrorImpact() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
}
