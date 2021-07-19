//
//  DaysInWeek.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 14/07/2021.
//

import Foundation


enum DaysInWeek: Int {
    case  monday = 1, thrusday, wednesday, tuesday, friday, saturday, sunday
}

extension DaysInWeek {
    var shortName : String {
        get {
            switch self {
            case .monday:
                return "Lun"
            case .thrusday:
                return "Mar"
            case .wednesday:
                return "Mie"
            case .tuesday:
                return "Jue"
            case .friday:
                return "Vie"
            case .saturday:
                return "Sab"
            case .sunday:
                return "Dom"
            }
        }
    }
    
    var initialName : String {
        get {
            switch self {
            case .monday:
                return "L"
            case .thrusday:
                return "M"
            case .wednesday:
                return "M"
            case .tuesday:
                return "J"
            case .friday:
                return "V"
            case .saturday:
                return "S"
            case .sunday:
                return "D"
            }
        }
    }
}

extension DaysInWeek {
    static var weekDays = [sunday, monday, thrusday, wednesday, tuesday, friday, saturday]
}
