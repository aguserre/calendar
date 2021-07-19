//
//  MainViewModel.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

class MainViewModel {
    
    var appTitle: String {
        return mainTitle
    }
    
    var buttonTitle: String {
        return dateSelected ? selectOtherDate : goToCalendar
    }
    
    var holidays = [HolidayModel]()
    
    var dateSelected = false

    func getHolidays(completion: @escaping ((Error?) -> (Void))) {
        if !holidays.isEmpty {
            completion(nil)
            return
        }
        ServiceManager().fetchHolidays() { holidays, error in
            if let error = error {
                completion(error)
            }
            if let holidays = holidays {
                self.holidays = holidays
                completion(nil)
            }
        }
    }
    
}
