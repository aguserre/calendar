//
//  CloseButton.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 07/07/2021.
//

import UIKit

final class CloseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        setConstraints()
    }

    fileprivate func setup() {
        let image = UIImage(systemName: "xmark.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        self.setImage(image, for: .normal)
        self.imageView?.tintColor = .gray
    }
    
    fileprivate func setConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 20),
            self.heightAnchor.constraint(equalToConstant: 20),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 15),
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 15),
        ])
    }
}
