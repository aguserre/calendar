//
//  UIViewExtension.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat = 8, corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}
