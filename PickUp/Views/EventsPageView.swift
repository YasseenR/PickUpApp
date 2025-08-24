//
//  EventsPageView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct EventsPageView: View {
    
    @State private var events = [
        EventModel(host: "Yasseen Rouni", title: "Pick Up Volleyball", date: "Friday May 30 3:30 PM - 5:30 PM", location: "Pearson Hall 3rd Floor Gym",sport: "Volleyball", skillLevel: .beginner, maxAttendees: 18, currentAttendees: 10, isOfficial: true, description: "Beginner Friendly Volleyball. Come and learn how to play with others in your same shoes!", imageName: nil),
        EventModel(host: "Tharani Kannan", title: "All Levels Basketball", date: "Saturday May 30 3:30 PN - 5:30 PM", location: "Pearson Hall 3rd Floor Gym", sport: "Basketball", skillLevel: .allLevels, maxAttendees: 15, currentAttendees: 13, isOfficial: true, description: "Pick up basketball open to all levels. Come test your skills", imageName: nil)
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
        
        ZStack {
            Rectangle()
                .fill(Color("Background"))
                .cornerRadius(20)
            VStack {
                HStack{
                    Text("\(eventModel.host)")
                }
                .frame(width: 350, alignment: .topLeading)
                Text("\(eventModel.title)")
                    .frame(width: 350, alignment: .topLeading)
                VStack {
                    
                    Image("gym")
                        .resizable()
                        .frame(width: 200, height: 100)
                    HStack {
                        Text("\(eventModel.date)")
                    }
                    .frame(width: 350, alignment: .topLeading)
                    HStack {
                        Text("\(eventModel.location)")
                    }
                    .frame(width: 350, alignment: .topLeading)
                    HStack {
                        Text("\(eventModel.attendeeStatus)")
                    }
                    .frame(width: 350, alignment: .topLeading)
                }
            }
        }
        .frame(width: 350, alignment: .topLeading)
        .padding(4)
    }
}

#Preview {
    EventsPageView()
}
