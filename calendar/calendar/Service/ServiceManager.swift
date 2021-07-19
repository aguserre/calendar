//
//  ServiceManager.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

import Foundation
import FirebaseDatabase
import CodableFirebase

class ServiceManager {
    
    var dataBaseRef: DatabaseReference!
    
    typealias FetchHolidaysCompletion = (([HolidayModel]?, Error?) -> Void)
    
    private func checkDatabaseReference() {
        if dataBaseRef != nil {
            dataBaseRef.removeAllObservers()
        }
    }
    
    func fetchHolidays(completion: @escaping FetchHolidaysCompletion) {
        checkDatabaseReference()
        dataBaseRef = Database.database().reference()
        dataBaseRef.observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                snapshot.forEach { snap in
                    if let holidaysDic = snap.value as? [[String : AnyObject]] {
                        do {
                            let holidays = try FirebaseDecoder().decode([HolidayModel].self, from: holidaysDic)
                            completion(holidays, nil)
                            return
                        } catch let error {
                            completion(nil, error)
                            return
                        }
                    }
                }
                completion(nil, nil)
                return
            }
        }
    }
}
