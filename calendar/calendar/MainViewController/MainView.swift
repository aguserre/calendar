//
//  MainView.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

import UIKit
import RxSwift

class MainView: UIView {
    
    let titleLabel: UILabel = prepareTitleLabel()
    let continueButton: UIButton = prepareContinueButton()
    let dateSelectedLabel: UILabel = prepareDateLabel()
    let descriptionLabel: UILabel = prepareDescLabel()
    
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
        addSubview(titleLabel)
        addSubview(continueButton)
        addSubview(dateSelectedLabel)
        addSubview(descriptionLabel)
    }
    
    func setConstraints() {
        [titleLabel, continueButton, dateSelectedLabel, descriptionLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            
            continueButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dateSelectedLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            dateSelectedLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateSelectedLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: dateSelectedLabel.bottomAnchor, constant: 10)
        ])
    }
    
    func setStyle() {
        backgroundColor = .black
    }
    
}

fileprivate func prepareContinueButton() -> UIButton {
    let button = UIButton()
    button.backgroundColor = .systemIndigo
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    button.setTitleColor(.white, for: .normal)
    button.roundCorners()
    
    return button
}
    
fileprivate func prepareDateLabel() -> UILabel {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    label.textColor = .white
    label.textAlignment = .center
        
    return label
}

fileprivate func prepareDescLabel() -> UILabel {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    label.numberOfLines = 0
    label.textColor = .systemIndigo
    label.textAlignment = .center
        
    return label
}

fileprivate func prepareTitleLabel() -> UILabel {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    label.numberOfLines = 0
    label.textColor = .white
    label.textAlignment = .center
        
    return label
}
