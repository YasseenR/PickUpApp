//
//  EventModel.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import Foundation

struct EventModel: Identifiable {
    let id = UUID()
    let host: String
    let title: String
    let date: Date
    let startTime: Date
    let endTime: Date
    let location: String
    let sport: String
    let skillLevel: SkillLevel
    let maxAttendees: Int
    let currentAttendees: Int
    let isOfficial: Bool
    let description: String
    let imageName: String?
    
    enum SkillLevel: String, CaseIterable {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
        case allLevels = "All Levels"
        
        var color: String {
            switch self {
            case .beginner: return "green"
            case .intermediate: return "orange"
            case .advanced: return "red"
            case .allLevels: return "blue"
            }
        }
    }
    
    var isFull: Bool {
        currentAttendees >= maxAttendees
    }
    
    var availableSpots: Int {
        maxAttendees - currentAttendees
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return "\(formatter.string(from: startTime)) - \(formatter.string(from: endTime))"
    }
    
    var formattedDateTime: String {
        "\(formattedDate) • \(formattedTime)"
    }
    
    var attendeeStatus: String {
        if isFull {
            return "Full"
        } else if availableSpots <= 3 {
            return "\(availableSpots) spots left"
        } else {
            return "\(currentAttendees)/\(maxAttendees) going"
        }
    }
}
