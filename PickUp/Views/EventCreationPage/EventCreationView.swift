//
//  EventCreationView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI
import FirebaseFirestore

struct EventCreationView: View {
    var body: some View {
        NavigationView {
            HeroActionView()
        }
    }
}

struct HeroActionView: View {
    var body: some View {
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
                addNewDocument()

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
                        .padding(.horizontal, 30)
                }
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

#Preview {
    EventCreationView()
}
