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
        EventModel(host: "Tharani Kannan", title: "All Levels Basketball", date: "Saturday May 30 3:30 PN - 5:30 PM", location: "PH 3rd Floor Gym", sport: "Basketball", skillLevel: .allLevels, maxAttendees: 15, currentAttendees: 13, isOfficial: true, description: "Pick up basketball open to all levels. Come test your skills", imageName: nil),
        EventModel(host: "Tharani Kannan", title: "All Levels Basketball", date: "Saturday May 30 3:30 PN - 5:30 PM", location: "PH 3rd Floor Gym", sport: "Basketball", skillLevel: .allLevels, maxAttendees: 15, currentAttendees: 15, isOfficial: false, description: "Pick up basketball open to all levels. Come test your skills", imageName: nil)
    ]
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Events")
                    .font(.headline)
                Text("Temple University")
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
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 160)
                    .overlay(
                        Image(systemName: "sportscourt.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    )
                    .padding(4)
                
                HStack(spacing: 4) {
                    Text(eventModel.isOfficial ? "Official" : "Unofficial")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(eventModel.isOfficial ? .accentTeal : .accentOrange)
                )
                .foregroundColor(.white)
                .padding(12)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("\(eventModel.title)")
                    .font(.headline)
                //Text("\(eventModel.host)")
                Text("\(eventModel.sport)")
                    .font(.caption)
                    .foregroundColor(.accentYellow)
                HStack {
                    Image(systemName: "calendar")
                        .font(.subheadline)
                    Text("\(eventModel.date)")
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "location.fill")
                        .font(.subheadline)
                    Text("\(eventModel.location)")
                        .font(.subheadline)
                }
                HStack {
                    Image(systemName: "person.fill")
                        .font(.caption)
                    Text("\(eventModel.host)")
                        .font(.caption)
                    Spacer()
                    Image(systemName: "person.2.fill")
                        .foregroundColor(eventModel.isFull ? .warning : .warning)
                    Text("\(eventModel.attendeeStatus)")
                        .font(.caption)
                        .foregroundColor(eventModel.isFull ? .warning : .warning)
                }

                /*Spacer()
                Text("\(eventModel.location)")
                Text("\(eventModel.date)")
                Text("\(eventModel.skillLevel.rawValue)")
                Text("\(eventModel.attendeeStatus)")*/
            }
            .padding(4)
        }
        .frame(width: 350, alignment: .topLeading)
        .padding(4)
        .foregroundColor(Color("Divider"))
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(eventModel.isOfficial ? Color(.accentBlue) : Color(.accentBlue))
        )
        
    }
}

#Preview {
    EventsPageView()
}
