//
//  MainView.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

import UIKit

class MainView: UIView {
    
    let continueButton: UIButton = prepareContinueButton()
    let dateSelectedLabel: UILabel = prepareDateLabel()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        setStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate extension MainView {
    
    func addSubviews() {
        addSubview(continueButton)
        addSubview(dateSelectedLabel)
    }
    
    func setConstraints() {
        [continueButton, dateSelectedLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            continueButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dateSelectedLabel.widthAnchor.constraint(equalTo: widthAnchor),
            dateSelectedLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setStyle() {
        backgroundColor = .black
    }
    
}

extension MainView {
    static func prepareContinueButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.roundCorners()
        
        return button
    }
    
    static func prepareDateLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        
        return label
        
    }
}
