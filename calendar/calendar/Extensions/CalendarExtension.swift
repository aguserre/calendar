//
//  CalendarExtension.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

import UIKit

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        guard let numberOfDays = dateComponents([.day], from: from, to: to).day else {
            return 0
        }
        
        return numberOfDays
    }

    func numberOfMonthsBetween(_ from: Date, and to: Date) -> Int {
        guard let numberOfMonth = dateComponents([.month], from: from, to: to).month else {
            return 0
        }
        
        return numberOfMonth
    }
    
    func startOfMonth(_ date: Date) -> Date {
        return self.date(from: self.dateComponents([.year, .month], from: date))!
    }
}
