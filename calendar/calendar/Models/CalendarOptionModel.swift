//
//  CalendarOptionModel.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 15/07/2021.
//

import Foundation


struct CalendarOptionsModel {
     let calendars: [CalendarOptionModel] = convertToMonthOption()
}

//Set how much month show in calendar
let maxMonthsToShow = 25

fileprivate func convertToMonthOption() -> [CalendarOptionModel] {
    var options = [CalendarOptionModel]()
    let today = Date()
    let calendar = Calendar.current

    for date in today.getMonths() {
        let comp = calendar.dateComponents([.month, .year], from: date)
        let month = comp.month ?? 1
        let monthModel = MonthsInYear(rawValue: month) ?? .january
        let year = comp.year ?? 1

        var daysInMonth = today.getDaysInMonth(month: monthModel, year: year)
        let startInDay = calendar.component(.weekday, from: Calendar.current.startOfMonth(date))
        
        //fill days after starting weekday
        daysInMonth.insert(contentsOf: repeatElement(0, count: startInDay - 1), at: 0)
        
        //fill days to complete 7x6 grill
        daysInMonth.append(contentsOf: repeatElement(0, count: 42 - daysInMonth.count))
        
        let calendar = CalendarOptionModel(month: comp.month ?? 1,
                                           year: comp.year ?? 2021,
                                      startInDay: startInDay,
                                      daysInMonth: daysInMonth)
        options.append(calendar)
    }
    
    return options
}



struct CalendarOptionModel {
    var month: Int = 0
    var year: Int = 0
    var startInDay: Int = 0
    var daysInMonth = [Int]()
}

extension CalendarOptionModel: Equatable {
    static func ==(lhs: CalendarOptionModel, rhs: CalendarOptionModel) -> Bool {
        return lhs.month == rhs.month && lhs.year == rhs.year
    }
}


