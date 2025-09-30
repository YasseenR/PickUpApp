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

extension FirebaseEventModel {
    init(from creationModel: EventCreationModel, host: String, isOfficial: Bool = false) {
        self.title = creationModel.title
        self.description = creationModel.description
        self.host = host
        self.sport = creationModel.sport.rawValue
        self.location = creationModel.location
        self.date = creationModel.eventDate // store the event date as a Date
        self.skillLevel = creationModel.skillLevel.rawValue
        self.maxAttendees = creationModel.maxAttendees
        self.currentAttendees = 0
        self.isOfficial = isOfficial
    }
}

enum Sport: String, CaseIterable, Codable {
    case basketball = "Basketball"
    case volleyball = "Volleyball"
    case badminton = "Badminton"
    case pickleball = "Pickleball"
    case tennis = "Tennis"
    case soccer = "Soccer"
    
    var displayName: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .basketball: return "figure.basketball"
        case .volleyball: return "figure.volleyball"
        case .badminton: return "figure.badminton"
        case .pickleball: return "figure.pickleball"
        case .tennis: return "figure.tennis"
        case .soccer: return "figure.indoor.soccer"
        }
    }
}

enum SkillLevel: String, CaseIterable, Codable {
    case allLevels = "All Levels"
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    
    var displayName: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .allLevels: return "person.3.fill"
        case .beginner: return "medal.fill"
        case .intermediate: return "medal.fill"
        case .advanced: return "medal.fill"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .allLevels: return .silver
        case .beginner: return .bronze
        case .intermediate: return .gold
        case .advanced: return .success
        }
    }
}
