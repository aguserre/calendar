//
//  MonthsInYear.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 15/07/2021.
//

import Foundation

enum MonthsInYear: Int, Encodable{
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
}

extension MonthsInYear {
    var shortName : String {
        get {
            switch self {
            case .january:
                return "january"
            case .february:
                return "february"
            case .march:
                return "march"
            case .april:
                return "april"
            case .may:
                return "may"
            case .june:
                return "june"
            case .july:
                return "july"
            case .august:
                return "august"
            case .september:
                return "september"
            case .october:
                return "october"
            case .november:
                return "november"
            case .december:
                return "december"
            }
        }
    }
}

extension MonthsInYear {
    static var montshInYear = [january, february, march, april, may, june, july, august, september, october, november, december]
}
