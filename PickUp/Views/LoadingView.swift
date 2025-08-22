//
//  LoadingView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI


struct LoadingView: View {
    @State private var isLoading = true
    var body: some View{
        VStack {
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .purple))
            } else {
                Text("Done!")
            }
        }
    }
}

#Preview {
    LoadingView()
}
