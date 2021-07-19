//
//  CalendarCollectionViewCell.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 15/07/2021.
//
import UIKit


class CalendarCollectionViewCell: UICollectionViewCell {
    
    var dayLabel: UILabel = prepareDayLabel()
    var isSelectedCell = false

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        setConstraints()
        setStyle()
    }
 
}

fileprivate extension CalendarCollectionViewCell {
    func addSubviews() {
        contentView.addSubview(dayLabel)
    }
    
    func setConstraints() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayLabel.widthAnchor.constraint(equalToConstant: kLabelWidth),
            dayLabel.heightAnchor.constraint(equalToConstant: kLabelWidth),
        ])
    }
    
    func setStyle() {
        contentView.backgroundColor =  .clear
    }
    
}

extension CalendarCollectionViewCell {
    func setupCell(day: Int, isHoliday: Bool, isWeekEnd: Bool) {
        dayLabel.text = day == 0 ? "" : String(day)
        let holidayColor: UIColor = .systemGreen
        let weekEndColor: UIColor = .gray
        let color: UIColor = isSelectedCell ? .black : .white
        
        dayLabel.textColor = isHoliday ? holidayColor : (isWeekEnd && !isHoliday) ? weekEndColor : color
        dayLabel.backgroundColor = isSelectedCell ? .systemIndigo : .clear
    }
}

fileprivate let kLabelWidth: CGFloat = 30

fileprivate func prepareDayLabel() -> UILabel {
    let labelDay = UILabel()
    labelDay.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    labelDay.textColor = .white
    labelDay.textAlignment = .center
    labelDay.roundCorners(radius: kLabelWidth / 2)

    return labelDay
}
