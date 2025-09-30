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

    func createEvent(eventData: EventCreationModel) {
        
        do {
            try FirestoreManager.shared.db.collection("games").addDocument(from: eventData) { error in
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
