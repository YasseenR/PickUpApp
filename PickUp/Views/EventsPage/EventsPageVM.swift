//
//  EventsPageVM.swift
//  PickUp
//
//  Created by Yasseen Rouni on 9/24/25.
//

import SwiftUI
import FirebaseFirestore
import Foundation

class EventsPageVM: ObservableObject {
    @Published var events: [EventModel] = []
    private var db = Firestore.firestore()
    
    init () {
        fetchEvents()
    }
    
    func fetchEvents() {
        db.collection("games")
                    .order(by: "date", descending: false) // upcoming first
                    .addSnapshotListener { snapshot, error in
                        if let error = error {
                            print("Error fetching games: \(error)")
                            return
                        }
                        
                        let firebaseEvents: [FirebaseEventModel] = snapshot?.documents.compactMap { doc in
                            try? doc.data(as: FirebaseEventModel.self)
                        } ?? []
                        
                        self.events = firebaseEvents.map { EventModel(from: $0) }
                        
                        
                        print(self.events)
                    }
    }
}
