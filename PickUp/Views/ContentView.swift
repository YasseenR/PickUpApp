//
//  ContentView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Button(action:  {
                    
                }) {
                    Text("Login")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
