//
//  EventsPageView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct EventsPageView: View {
    
    @State private var events = [
        EventModel(host: "Yasseen Rouni", title: "Pick Up Volleyball", date: "Friday May 30 3:30 PM - 5:30 PM", location: "PH 3rd Floor Gym",sport: "Volleyball", skillLevel: .beginner, maxAttendees: 18, currentAttendees: 10, isOfficial: true, description: "Beginner Friendly Volleyball. Come and learn how to play with others in your same shoes!", imageName: nil),
        EventModel(host: "Tharani Kannan", title: "All Levels Basketball", date: "Saturday May 30 3:30 PN - 5:30 PM", location: "PH 3rd Floor Gym", sport: "Basketball", skillLevel: .allLevels, maxAttendees: 15, currentAttendees: 13, isOfficial: true, description: "Pick up basketball open to all levels. Come test your skills", imageName: nil)
    ]
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Temple University")
                
                Text("Events")
            }
            .frame(height: 50)
            .padding()
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach($events) { $event in
                        EventCard(eventModel: $event)
                    }
                }
            }
        }
    }
}

struct LocationCard: View {
    var body: some View {
        VStack {
            
        }
    }
}

struct EventCard: View {
    @Binding var eventModel: EventModel
    
    var body: some View {
        
        
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 160)
                    .overlay(
                        Image(systemName: "sportscourt.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    )
            }
            VStack(alignment: .leading, spacing: 4) {
                
                HStack {
                    Text("\(eventModel.host)")
                    Spacer()
                    Text("\(eventModel.sport)")
                }
                
                HStack {
                    Text("\(eventModel.title)")
                    Spacer()
                    Text("\(eventModel.location)")
                }
                Text("\(eventModel.date)")
                HStack {
                    Text("\(eventModel.skillLevel.rawValue)")
                    Spacer()
                    Text("\(eventModel.attendeeStatus)")
                }
            }
        }
        .frame(width: 350, alignment: .topLeading)
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.accentBlue)))
        
    }
}

#Preview {
    EventsPageView()
}
