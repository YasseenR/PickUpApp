//
//  EventCardView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 9/2/25.
//

import SwiftUI

struct EventCard: View {
    @Binding var eventModel: EventModel
    @Binding var showEvent: Bool
    
    var body: some View {
        
        
        Button(action: {showEvent = true}) { VStack {
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
                    Image(systemName: eventModel.isOfficial ? "checkmark.seal.fill" : "person.2.fill")
                        .font(.caption)
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
            VStack(alignment: .leading, spacing: 6) {
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
                        .font(.caption)
                        .foregroundColor(eventModel.isFull ? .warning : .green)
                    Text("\(eventModel.attendeeStatus)")
                        .foregroundColor(eventModel.isFull ? .warning : .green)
                        .font(.caption)
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
                .fill(eventModel.isOfficial ? Color.gray.opacity(0.2) : Color(.cherryRed))
        )
            
        }
    }
}
