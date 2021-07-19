//
//  HolidayModel.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

import UIKit

struct HolidaysModel {
    var holidays: [HolidayModel]?
}

extension HolidaysModel: Decodable, Encodable {
    enum CodingKeys: String, CodingKey {
        case holidays

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.holidays = try container.decodeIfPresent([HolidayModel].self, forKey: .holidays)
    }
}

struct HolidayModel {
    var id: String?
    var name: String?
    var date: String?
    var country: String?
}

extension HolidayModel: Decodable, Encodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date
        case country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
    }
    
}
