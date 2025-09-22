//
//  EventCreationModel.swift
//  PickUp
//
//  Created by Yasseen Rouni on 9/20/25.
//

import SwiftUI

struct EventCreationModel: Codable {
    var title: String = ""
    var description: String = ""
    var sport: Sport = .basketball
    var skillLevel: SkillLevel = .allLevels
    var eventDate: Date = Date()
    var startTime: Date = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date()) ?? Date()
    var endTime: Date = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date()) ?? Date()
    var location: String = ""
    var maxAttendees: Int = 10
    
    var formattedDateTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        let combinedDate = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: startTime),
                                                minute: Calendar.current.component(.minute, from: startTime),
                                                second: 0,
                                                of: eventDate) ?? eventDate
        
        return "\(dateFormatter.string(from: combinedDate)) • \(timeFormatter.string(from: startTime)) - \(timeFormatter.string(from: endTime))"
    }
}
