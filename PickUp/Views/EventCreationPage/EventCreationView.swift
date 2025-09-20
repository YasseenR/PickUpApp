//
//  EventCreationView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI
import FirebaseFirestore

enum EventCreationState {
    case welcome
    case details
    case customization
}

struct EventCreationView: View {
    @State private var currentState: EventCreationState = .details
    @State private var eventData = EventCreationModel()
    var body: some View {
        NavigationView {
            
            Group {
                switch currentState {
                case .welcome:
                    welcomeView
                case .details:
                    detailsView
                case .customization:
                    welcomeView
                }
            }
        }
    }
    
    private var welcomeView: some View {
        VStack(spacing: 40) {
            Spacer()
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.cherryRed)
            VStack {
                Text("Create Your Event")
                    .font(.system(size: 30))
                    .bold()
                Text("Host your match, invite players, and play your way.")
                    .font(.caption)
            }
            VStack(spacing: 16) {
                BenefitRow(icon: "person.2.fill", title: "Connect Players", description: "Bring together players of all skill levels")
                BenefitRow(icon: "calendar.badge.plus", title: "Schedule Games", description: "Set your preferred time and location")
                BenefitRow(icon: "star.fill", title: "Build Community", description: "Create lasting connections through sports")
                
            }
            .padding(.horizontal, 25)
            Spacer()
            
            Button(action: {
                // Add a new document with a generated ID
                currentState = .customization

            } ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.cherryRed)
                        .frame(height: 60)
                        .overlay(
                            Text("Start Creating Event")
                                .foregroundStyle(.white)
                                .bold()
                        )
                        .padding(30)
                }
            }
            
            
        }
    }
    
    private var detailsView: some View {
        VStack {
            Text("Event Creation Page")
            ScrollView {
                VStack {
                    Text("Choose your sport")
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(Sport.allCases, id: \.self) { sport in
                            SportCard(sport: sport, isSelected: eventData.sport == sport, action: {eventData.sport = sport})
                        }
                    }
                    .padding()
                }
            }

        }
    }
}



func action() {
    
}

struct SportCard: View {
    let sport: Sport
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: sport.icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? .white : .cherryRed)
                Text("\(sport.displayName)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(isSelected ? .white : .cherryRed)
            }
            .foregroundStyle(Color(.white))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? .cherryRed : Color(.systemGray6))
            )
            
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BenefitRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.cherryRed)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct CustomizationView: View {
    var body: some View {
        VStack {
            Text("Customization View")
        }
    }
}

enum Sport: String, CaseIterable {
    case basketball = "Basketball"
    case volleyball = "Volleyball"
    case badminton = "Badminton"
    case pickleball = "Pickleball"
    case tennis = "Tennis"
    case soccer = "Soccer"
    
    var displayName: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .basketball: return "figure.basketball"
        case .volleyball: return "figure.volleyball"
        case .badminton: return "figure.badminton"
        case .pickleball: return "figure.pickleball"
        case .tennis: return "figure.tennis"
        case .soccer: return "figure.indoor.soccer"
        }
    }
}

func addNewDocument() {
    FirestoreManager.shared.db.collection("users").addDocument(data: ["name": "Yasseen", "createdAt": Timestamp(date: Date())]) { error in
        if let error = error {
            print("Error adding document: \(error)")
        } else {
            print("Document added successfully!")
        }
    }
}

#Preview {
    EventCreationView()
}
