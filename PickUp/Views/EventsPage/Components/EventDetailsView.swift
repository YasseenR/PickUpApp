//
//  EventDetailsView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 9/2/25.
//

import SwiftUI

struct Players: Identifiable {
    let id = UUID()
    let name: String
}

struct EventDetailsView: View {
    @Binding var eventModel: EventModel
    @Binding var showEvent: Bool
    
    var players: [Players] = [Players(name: "Alejandro Vasquez"), Players(name:"Chihiro Chizuru"), Players(name:"Naruto Uzumaki"), Players(name:"Yaseen Rouni-belhadj"), Players(name:"Go Dong"), Players(name:"Chief Man"), Players(name: "John Boyer"), Players(name:"Joshua Carte"), Players(name:"Bailey Smith")]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Rectangle()
                .fill(Color.black.opacity(0.2))
                .frame(height: 320)
                .overlay(
                    Image(systemName: "sportscourt.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                )
        }
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.2.fill")
                        .font(.caption)
                    Text(eventModel.attendeeStatus)
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(eventModel.isFull ? .accentOrange : .cherryRed)
                )
                .foregroundColor(.white)
                Text(eventModel.title)
                //.font(.headline)
                    .font(.system(size: 32))
                VStack(spacing: 10) {
                    
                    HStack {
                        //Image(systemName: "calendar")
                        Text("\(eventModel.date)")
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack {
                        //Image(systemName: "location")
                        Text("\(eventModel.location)")
                            .font(.subheadline)
                        Spacer()
                    }
                }
                Divider()
                VStack(alignment:.leading) {
                    Text("Host")
                        .font(.system(size: 20))
                        .bold()
                    HStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 20, height: 20)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            )
                        Text("\(eventModel.host)")
                    }
                }
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Event Details")
                    //.font(.headline)
                        .font(.system(size: 20))
                        .bold()
                    HStack(spacing: 0) {
                        Text("Activity: ")
                            .bold()
                        Text("\(eventModel.sport)")
                    }
                    HStack(spacing: 0) {
                        Text("Event Type: ")
                            .bold()
                        Text("Public")
                    }
                }
                .font(.system(size: 12))
                Divider()
                Text("Players")
                HStack {
                    ForEach(players) {player in
                        VStack {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Image(systemName: "person.fill.checkmark")
                                        .font(.system(size: 15))
                                        .foregroundColor(.gray)
                                )
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            Spacer()
        }
        HStack {
            Spacer()
            Button(action: {showEvent = false}){
                VStack {
                    Text("Reserve a spot")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.cherryRed)
                )
                .foregroundColor(.white)
            }
            Spacer()
        }
    }
}

#Preview {
    @State var event = EventModel(host: "Tharani Kannan", title: "All Levels Basketball", date: "Saturday May 30 3:30 PM - 5:30 PM", location: "Pearson Hall 3rd Floor Gym", sport: "Basketball", skillLevel: .allLevels, maxAttendees: 15, currentAttendees: 15, isOfficial: false, description: "Pick up basketball open to all levels. Come test your skills", imageName: nil)
    @State var bruh = false
    EventDetailsView(eventModel: $event, showEvent: $bruh)
}
