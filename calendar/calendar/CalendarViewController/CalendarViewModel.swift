//
//  CalendarViewModel.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 14/07/2021.
//

import Foundation
import UIKit


class CalendarViewModel {
    
    init(holidays: [HolidayModel]) {
        self.holidays = holidays
        self.calendars = CalendarOptionsModel().calendars
        self.indexSelected = calendars.count / 2
        self.initialIndex = indexSelected
        self.calendarSelected = calendars[indexSelected]
    }
    
    let calendars: [CalendarOptionModel]
    
    var calendarSelected: CalendarOptionModel
    
    func reloadItems() {
        calendarSelected = calendars[indexSelected]
    }
    
    var holidays: [HolidayModel]
    
    var months: [MonthsInYear] {
        var months = [MonthsInYear]()
        calendars.forEach { calendar in
            months.append(MonthsInYear(rawValue: calendar.month) ?? .january)
        }
        
        return months
    }
                
    var swipeRight = UISwipeGestureRecognizer()
    var swipeLeft = UISwipeGestureRecognizer()
    
    func addGesture(view: UIView) {
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    
    func setDelegates(collection: UICollectionView, delegate: CalendarViewController) {
        collection.delegate = delegate
        collection.dataSource = delegate
    }
    
    func registerCell(collection: UICollectionView) {
        collection.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private let cellIdentifier = "CalendarCollectionViewCell"
    
    var titleLabelText: String {
        return calendarString
    }
    
    func createDate(indexSelected: IndexPath) {
        var dateComponents = DateComponents()
        dateComponents.year = calendarSelected.year
        dateComponents.month = calendarSelected.month
        dateComponents.day = calendarSelected.daysInMonth[indexSelected.row]
        guard let someDate = Calendar.current.date(from: dateComponents) else {
            return
        }
        
        dateSelected = someDate
    }
    
    func checkIsDaySelected() -> Bool {
        
        
        return true
    }
    
    func convertToDate(index: IndexPath) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = calendarSelected.year
        dateComponents.month = calendarSelected.month
        dateComponents.day = calendarSelected.daysInMonth[index.row]
        guard let someDate = Calendar.current.date(from: dateComponents) else {
            return Date()
        }
        
        return someDate
    }
    
    func checkIsWeekEnd(date: Date) -> Bool {        
        return Calendar.current.isDateInWeekend(date)
    }
    
    func checkIsHoliday(date: Date) -> Bool {
        let holidays = holidays.map({ $0.date })
        return holidays.contains(date.convertToEqualBackendString())
    }
    
    func getDateDescription() -> String? {
        guard let date = holidays.filter({ $0.date == dateSelected.convertToEqualBackendString() }).first else {
            return ""
        }
        
        return date.name
    }
    
    var dateDiffDays: Int {
        return Date().numberOfDaysTo(date: dateSelected)
    }
    
    var subtitleMonthText: String {
        let calendar = calendarSelected
        let month = MonthsInYear(rawValue: calendar.month) ?? .january
        let year = calendar.year
        
        return month.shortName.capitalized + " \(year)"
    }
    
    func obtaintDescriptionText() -> String {
        let string = dateDiffDays < 0 ? oldDateMessage : "\(daysRemaining): \(dateDiffDays)"
        return string
    }
    
    var dateSelected: Date = Date()
    
    var indexSelected = 0
    
    let maxIndex = maxMonthsToShow - 1
    
    let minIndex = 0
    
    let cellHeight = 50.0
    
    let maxItemsVertical = 6.0
    
    let maxItemsHorizontal = 7.0

    func addIndex() {
        if indexSelected < maxIndex {
            indexSelected += 1
        }
    }

    var initialIndex = 0
    
    var isMaxIndexSelected: Bool {
        return indexSelected == maxIndex
    }
    
    func delIndex() {
        if indexSelected > minIndex {
            indexSelected -= 1
        }
    }
    
    var buttonTitle: String {
        return confirmDate
    }
    
    var isMinIndexSelected: Bool {
        return indexSelected == minIndex
    }
    
    var labelText: String {
        let monthCount = indexSelected - initialIndex
        let pref = monthCount == 1 ? month : pluralMonth
        let dateString = "\(monthCount) \(pref) - \(dateSelected.convertToString())"
        
        return dateString
    }
    
    func updateRows(oldIndexSelected: IndexPath? ,newIndexSelection: IndexPath?) -> [IndexPath] {
        var indexs = [IndexPath]()
        if let oldIndexSelection = oldIndexSelected  {
            indexs.append(oldIndexSelection)
        }
        if let newIndexSelection = newIndexSelection  {
            indexs.append(newIndexSelection)
        }
        
        return indexs
    }
    
    
}

