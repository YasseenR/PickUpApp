//
//  EventModel.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import Foundation
import FirebaseFirestore


struct FirebaseEventModel: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var host: String
    var sport: String
    var location: String
    var date: Date
    var skillLevel: String
    var maxAttendees: Int
    var currentAttendees: Int
    var isOfficial: Bool
}


struct EventModel: Identifiable, Codable {
    @DocumentID var id: String?
    let host: String
    let title: String
    let date: String
    let location: String
    let sport: String
    let skillLevel: SkillLevel
    let maxAttendees: Int
    let currentAttendees: Int
    let isOfficial: Bool
    let description: String
    let imageName: String?
    
    enum SkillLevel: String, CaseIterable, Codable {
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

extension EventModel {
    init(from firebaseModel: FirebaseEventModel) {
        self.id = firebaseModel.id
        self.host = firebaseModel.host
        self.title = firebaseModel.title
        self.date = EventModel.formatDate(firebaseModel.date) // convert Date → String
        self.location = firebaseModel.location
        self.sport = firebaseModel.sport
        self.skillLevel = SkillLevel(rawValue: firebaseModel.skillLevel) ?? .allLevels
        self.maxAttendees = firebaseModel.maxAttendees
        self.currentAttendees = firebaseModel.currentAttendees
        self.isOfficial = firebaseModel.isOfficial
        self.description = firebaseModel.description
        self.imageName = nil // or generate a default if you want
    }
    
    private static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

