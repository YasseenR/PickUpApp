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
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: eventModel.isOfficial ? "checkmark.seal.fill" : "person.2.fill")
                    .font(.caption)
                Text(eventModel.isOfficial ? "Official" : "Unofficial")
                    .font(.caption)
                    .fontWeight(.medium)
            }
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(eventModel.isOfficial ? .accentTeal : .accentOrange)
                )
                .foregroundColor(.white)
            Text(eventModel.title)
                //.font(.headline)
                .font(.system(size: 40))
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
            Button(action: {}) {
                Image(systemName: "calendar.badge.plus")
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                        .fill(.blue)
                    )
                    .foregroundColor(.white)
                
            }
        }
        .padding(.horizontal, 20)
        Spacer()
        
        VStack(alignment: .leading) {
            Text("Players")
            HStack {
                ForEach(players) {player in
                    VStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 30, height: 30)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                            )
                    }
                }
            }
        }
        Spacer()
        
        HStack {
            Spacer()
            Button(action: {showEvent = false}){
                VStack {
                    Text("Reserve a spot")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.accentTeal)
                )
                .foregroundColor(.white)
            }
            Spacer()
        }
    
    }
}

#Preview {
    @State var event = EventModel(host: "Tharani Kannan", title: "All Levels Basketball", date: "Saturday May 30 3:30 PM - 5:30 PM", location: "PH 3rd Floor Gym", sport: "Basketball", skillLevel: .allLevels, maxAttendees: 15, currentAttendees: 15, isOfficial: false, description: "Pick up basketball open to all levels. Come test your skills", imageName: nil)
    @State var bruh = false
    EventDetailsView(eventModel: $event, showEvent: $bruh)
}
