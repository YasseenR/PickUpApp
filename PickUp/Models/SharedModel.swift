//
//  SharedModel.swift
//  PickUp
//
//  Created by Yasseen Rouni on 9/15/25.
//
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    let db: Firestore
    
    private init() {
        db = Firestore.firestore()
    }
}
