//
//  PickUpView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct PickUpView: View {
    var body: some View {
        ZStack {
            TabView {
                NavigationStack {
                    ZStack {
                        Color(.background)
                            .ignoresSafeArea()
                    EventsPageView()
                        .toolbarBackground(Color.gray.opacity(0.01), for: .tabBar)
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                }
                }
                .tabItem {
                    Label("Events", systemImage: "house")                    .environment(\.symbolVariants, .none)
                }
                .tag(0)
                NavigationStack {
                    EventCreationView()
                        .toolbarBackground(Color.gray.opacity(0.01), for: .tabBar)
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                }
                .tabItem{
                    Label("Create Event", systemImage: "plus.app")                    .environment(\.symbolVariants, .none)
                }
                .tag(1)
                NavigationStack {
                    ProfileView()
                        .toolbarBackground(Color.gray.opacity(0.01), for: .tabBar)
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                }
                .tabItem {
                    Label("Profile", systemImage: "person")
                        .environment(\.symbolVariants, .none)
                }
                .tag(2)
            }
            .tint(Color(.cherryRed))
        }
    }
}

#Preview {
    PickUpView()
}
