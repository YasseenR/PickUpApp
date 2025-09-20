//
//  EventsPageView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct EventsPageView: View {
    @State private var showEvent = false
    @State private var searchText = ""
    
    @State private var events = [
        EventModel(host: "Campus Rec", title: "Pick Up Volleyball", date: "Friday May 30 3:30 PM - 5:30 PM", location: "PH 3rd Floor Gym",sport: "Volleyball", skillLevel: .beginner, maxAttendees: 18, currentAttendees: 10, isOfficial: true, description: "Beginner Friendly Volleyball. Come and learn how to play with others in your same shoes!", imageName: nil),
        EventModel(host: "Campus Rec", title: "All Levels Basketball", date: "Saturday May 30 3:30 PM - 5:30 PM", location: "PH 3rd Floor Gym", sport: "Basketball", skillLevel: .allLevels, maxAttendees: 15, currentAttendees: 13, isOfficial: true, description: "Pick up basketball open to all levels. Come test your skills", imageName: nil),
        EventModel(host: "Tharani Kannan", title: "All Levels Basketball", date: "Saturday May 30 3:30 PM - 5:30 PM", location: "PH 3rd Floor Gym", sport: "Basketball", skillLevel: .allLevels, maxAttendees: 15, currentAttendees: 15, isOfficial: false, description: "Pick up basketball open to all levels. Come test your skills", imageName: nil)
    ]
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Events")
                    .font(.headline)
                Text("Temple University")
                SearchBar(text: $searchText)
            }
            .frame(height: 50)
            .foregroundStyle(.textPrimary)
            .padding()
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach($events) { $event in
                        EventCard(eventModel: $event, showEvent: $showEvent)
                    }
                }
            }
        }
        .sheet(isPresented: $showEvent) {
            EventDetailsView(eventModel: $events[0], showEvent: $showEvent)
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search...", text: $text)
                .foregroundColor(.white)
                .focused($isFocused)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    isFocused = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.cardBackground)) // card-style dark background
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.cherryRed), lineWidth: isFocused ? 2 : 0) // teal accent border when focused
        )
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.6), radius: 4, x: 0, y: 2)
    }
}


struct LocationCard: View {
    var body: some View {
        VStack {
            
        }
    }
}


#Preview {
    EventsPageView()
}
