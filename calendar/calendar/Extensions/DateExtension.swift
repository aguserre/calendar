//
//  DateExtension.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

import UIKit


extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: self)
    }
    
    func convertToEqualBackendString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: self)
    }
    
    func numberOfDaysTo(date: Date) -> Int {
        return Calendar.current.numberOfDaysBetween(self, and: date)
    }
    
    func getMonths() -> [Date] {
        var monthCounter = 1
        var dates = [Date()]

        while dates.count < maxMonthsToShow {
            
            dates.append(Calendar.current.date(byAdding: .month, value: -monthCounter, to: self) ?? Date())
            dates.append(Calendar.current.date(byAdding: .month, value: monthCounter, to: self) ?? Date())
            monthCounter += 1
        }
        
        return dates.sorted { $0.compare($1) == .orderedAscending }
    }
    
    func getDaysInMonth(month: MonthsInYear, year: Int) -> [Int] {
        var days = [Int]()
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month.rawValue

        let calendar = Calendar.current
        let datez = calendar.date(from: dateComponents)
        let interval = calendar.dateInterval(of: .month, for: datez!)!

        guard let daysCantity = calendar.dateComponents([.day], from: interval.start, to: interval.end).day else {
            return []
        }
        Range(1...daysCantity).forEach { day in
            days.append(day)
        }
        
        return days
    }
}
