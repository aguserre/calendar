//
//  CalendarView.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 14/07/2021.
//

import UIKit
import RxSwift


class CalendarView: UIView {
    
    let titleLabel: UILabel = prepareTitleLabel()
    let subtitleLabel: UILabel = prepareSubtitleLabel()
    let backButton = CloseButton()
    let daysNameStack: UIStackView = prepareStackView()
    let selectedDateLabel: UILabel = prepareSelectedDateLabel()
    let calendarCollectionView: UICollectionView = prepareCalendarCollectionView()
    let selectButton: UIButton = preparePrimaryButton()
    let descriptionLabel: UILabel = prepareDescriptionLabel()
    var collectionHeight: NSLayoutConstraint!
    
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

fileprivate extension CalendarView {
    
    func addSubviews() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(daysNameStack)
        addSubview(calendarCollectionView)
        addSubview(selectedDateLabel)
        addSubview(descriptionLabel)
        addSubview(selectButton)
    }
    
    func setConstraints() {
        [titleLabel, subtitleLabel, daysNameStack, calendarCollectionView, selectedDateLabel, descriptionLabel, selectButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        collectionHeight = calendarCollectionView.heightAnchor.constraint(equalToConstant: 0)
        collectionHeight.isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: minPadding),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: primaryPadding),
            subtitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            daysNameStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: secondaryPadding),
            daysNameStack.widthAnchor.constraint(equalTo: widthAnchor),
            
            calendarCollectionView.topAnchor.constraint(equalTo: daysNameStack.bottomAnchor, constant: minPadding),
            calendarCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            calendarCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            
            selectedDateLabel.topAnchor.constraint(equalTo: calendarCollectionView.bottomAnchor, constant: secondaryPadding),
            selectedDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: selectedDateLabel.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: selectedDateLabel.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: selectedDateLabel.widthAnchor),
            
            selectButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            selectButton.heightAnchor.constraint(equalToConstant: 50),
            selectButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func setStyle() {
        backgroundColor = .black
    }
    
}

fileprivate let primaryPadding: CGFloat = 35
fileprivate let secondaryPadding: CGFloat = 20
fileprivate let minPadding: CGFloat = 10


fileprivate func prepareStackView() -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    DaysInWeek.weekDays.forEach { day in
        let labelDay = UILabel()
        labelDay.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        labelDay.textColor = .white
        labelDay.textAlignment = .center
        labelDay.text = day.initialName
        stackView.addArrangedSubview(labelDay)
    }
    
    return stackView
}

fileprivate func prepareCalendarCollectionView() -> UICollectionView {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.isPagingEnabled = false
    collection.backgroundColor = .clear
    collection.isScrollEnabled = false
    collection.showsVerticalScrollIndicator = false
    collection.showsHorizontalScrollIndicator = false
    
    return collection
}

fileprivate func prepareTitleLabel() -> UILabel {
    let labelDate = prepareSelectedDateLabel()
    labelDate.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    return labelDate
}

fileprivate func prepareSubtitleLabel() -> UILabel {
    let labelDate = prepareSelectedDateLabel()
    labelDate.textAlignment = .left
    
    return labelDate
}

fileprivate func prepareSelectedDateLabel() -> UILabel {
    let labelDate = UILabel()
    labelDate.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    labelDate.textColor = .white
    labelDate.textAlignment = .center
    
    return labelDate
}

fileprivate func prepareDescriptionLabel() -> UILabel {
    let labelDate = UILabel()
    labelDate.isHidden = true
    labelDate.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    labelDate.textColor = .white
    labelDate.textAlignment = .center
    
    return labelDate
}

fileprivate func preparePrimaryButton() -> UIButton {
    let button = UIButton()
    button.backgroundColor = .systemIndigo
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    button.setTitleColor(.white, for: .normal)
    button.roundCorners()
    
    return button
}
