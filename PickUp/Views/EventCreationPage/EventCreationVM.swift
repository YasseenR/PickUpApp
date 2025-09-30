//
//  EventCreationVM.swift
//  PickUp
//
//  Created by Yasseen Rouni on 9/30/25.
//
import Foundation
import SwiftUI
import FirebaseFirestore

class EventCreationVM: ObservableObject {
    func addNewDocument() {
        FirestoreManager.shared.db.collection("users").addDocument(data: ["name": "Yasseen", "createdAt": Timestamp(date: Date())]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully!")
            }
        }
    }

    func createEvent(eventData: EventCreationModel, host: String) {
        
        print(eventData.eventDate)
        print(eventData.startTime)
        print(eventData.endTime)
        let firebaseEvent = FirebaseEventModel(from: eventData, host: host, isOfficial: false)
        
        do {
            try FirestoreManager.shared.db.collection("games").addDocument(from: firebaseEvent) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully!")
                }
            }
        } catch let error {
            print("Error writing to document")
        }
    }
}
