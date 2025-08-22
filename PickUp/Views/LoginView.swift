//
//  LoginView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack {
            HeroLoginView()
        }
    }
}

struct HeroLoginView: View {
    var body: some View{
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


#Preview {
    LoginView()
}

