//
//  LoginView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI
import FirebaseAnalytics


struct LoginView: View {
    @State var navigate = false
    var body: some View {
        if !navigate {
            HeroLoginView(navigate: $navigate)
        } else {
            PickUpView()
        }
    }
}



struct HeroLoginView: View {
    @Binding var navigate: Bool
    var body: some View{
            Button("Login"){
                navigate = true
                print(Date.init())
            }
                .padding()
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color("TextPrimary"))
                .background(Color("PrimaryPink"))
                .cornerRadius(10)
                .analyticsScreen(name: "\(HeroLoginView.self)")

            // Invisible NavigationLink controlled by state
        }
}


#Preview {
    LoginView()
}

