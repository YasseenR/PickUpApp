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
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 120)
                    .overlay(
                        Image(systemName: "sportscourt.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    )
                    .padding(4)
                
                HStack(spacing: 4) {
                    Image(systemName: "person.2.fill")
                        .font(.caption)
                        .foregroundColor(.white)
                    Text("\(eventModel.currentAttendees)")
                        .foregroundColor(.white)
                        .font(.caption)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(.cherryRed)
                )
                .foregroundColor(.white)
                .padding(12)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text("\(eventModel.title)")
                    .font(.headline)
                //Text("\(eventModel.host)")
                Text("\(eventModel.skillLevel) \(eventModel.sport)")
                    .font(.caption)
                    .foregroundColor(.cherryRed)
                Divider()
                    .overlay(Color.divider)
                HStack {
                    Image(systemName: "clock")
                        .font(.caption)
                        .foregroundStyle(.textPrimary)
                        .foregroundStyle(.textPrimary)
                    Text("\(eventModel.date)")
                        .font(.caption)
                        .foregroundStyle(.textPrimary)
                }
                HStack {
                    Image(systemName: "location.fill")
                        .font(.caption)
                        .foregroundStyle(.textPrimary)
                    Text("\(eventModel.location)")
                        .font(.caption)
                        .foregroundStyle(.textPrimary)
                }
                Divider()
                    .overlay(Color.divider)
                HStack {
                    Image(systemName: "person.fill")
                        .font(.caption)
                        .foregroundStyle(.textPrimary)
                    Text("\(eventModel.host)")
                        .font(.caption)
                        .foregroundStyle(.textPrimary)
                    Spacer()
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
        .foregroundColor(Color(.textPrimary))
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.border.opacity(0.2)), lineWidth: 3)
                .fill(Color(.cardBackground)))
        
        }
        .padding(4)
    }
}

