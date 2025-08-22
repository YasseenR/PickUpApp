//
//  PickUpView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct PickUpView: View {
    var body: some View {
        TabView {
            NavigationStack {
                EventsPageView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Event Page")
            }
            NavigationStack {
                EventCreationView()
            }
            .tabItem{
                Image(systemName: "plus.app.fill")
                Text("Create Event")
            }
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
        .background()
    }
}

#Preview {
    PickUpView()
}
