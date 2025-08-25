//
//  ProfileView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var showingImagePicker = false
    @State private var profileImage: UIImage?
    @State private var isEditingProfile = false
    
    // Mock data - replace with actual user data
    @State private var userName = "Alex Johnson"
    @State private var userEmail = "alex.johnson@university.edu"
    @State private var userSummary = "Passionate basketball player looking for competitive pickup games. Available most evenings and weekends."
    @State private var skillLevel = "Intermediate"
    @State private var preferredSports = ["Basketball", "Volleyball", "Soccer"]
    
    // Stats
    @State private var gamesJoined = 24
    @State private var gamesPlayed = 18
    @State private var eventsHosted = 3
    @State private var totalPlayTime = "32 hours"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header Section
                    profileHeaderSection
                    
                    // Stats Section
                    statsSection
                    
                    // About Section
                    aboutSection
                    
                    // Settings Section
                    settingsSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditingProfile ? "Done" : "Edit") {
                        isEditingProfile.toggle()
                    }
                    .foregroundColor(.blue)
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $profileImage)
        }
    }
    
    // MARK: - Profile Header Section
    private var profileHeaderSection: some View {
        VStack(spacing: 16) {
            // Profile Picture
            Button(action: {
                if isEditingProfile {
                    showingImagePicker = true
                }
            }) {
                ZStack {
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    if isEditingProfile {
                        Circle()
                            .fill(Color.blue.opacity(0.8))
                            .frame(width: 32, height: 32)
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            )
                            .offset(x: 40, y: 40)
                    }
                }
            }
            .disabled(!isEditingProfile)
            
            // User Info
            VStack(spacing: 8) {
                if isEditingProfile {
                    TextField("Name", text: $userName)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    Text(userName)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                Text(userEmail)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Stats Section
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Activity Stats")
                .font(.headline)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                StatCard(title: "Games Joined", value: "\(gamesJoined)", icon: "person.2.fill", color: .blue)
                StatCard(title: "Games Played", value: "\(gamesPlayed)", icon: "sportscourt.fill", color: .green)
                StatCard(title: "Events Hosted", value: "\(eventsHosted)", icon: "flag.fill", color: .orange)
                StatCard(title: "Total Play Time", value: totalPlayTime, icon: "clock.fill", color: .purple)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - About Section
    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("About")
                .font(.headline)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 12) {
                // Skill Level
                HStack {
                    Label("Skill Level", systemImage: "star.fill")
                        .foregroundColor(.orange)
                    Spacer()
                    if isEditingProfile {
                        Picker("Skill Level", selection: $skillLevel) {
                            Text("Beginner").tag("Beginner")
                            Text("Intermediate").tag("Intermediate")
                            Text("Advanced").tag("Advanced")
                            Text("Expert").tag("Expert")
                        }
                        .pickerStyle(MenuPickerStyle())
                    } else {
                        Text(skillLevel)
                            .foregroundColor(.secondary)
                    }
                }
                
                Divider()
                
                // Preferred Sports
                VStack(alignment: .leading, spacing: 8) {
                    Label("Preferred Sports", systemImage: "sportscourt.fill")
                        .foregroundColor(.blue)
                    
                    if isEditingProfile {
                        // Add sport selection here
                        Text("Basketball, Volleyball, Soccer")
                            .foregroundColor(.secondary)
                            .italic()
                    } else {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                            ForEach(preferredSports, id: \.self) { sport in
                                Text(sport)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                
                Divider()
                
                // Summary
                VStack(alignment: .leading, spacing: 8) {
                    Label("Summary", systemImage: "text.quote")
                        .foregroundColor(.green)
                    
                    if isEditingProfile {
                        TextField("Tell us about yourself...", text: $userSummary, axis: .vertical)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .lineLimit(3...6)
                    } else {
                        Text(userSummary)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Settings Section
    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Settings")
                .font(.headline)
                .fontWeight(.semibold)
            
            VStack(spacing: 0) {
                SettingsRow(icon: "bell.fill", title: "Notifications", color: .red) {
                    // Handle notifications
                }
                
                Divider()
                    .padding(.leading, 44)
                
                SettingsRow(icon: "lock.fill", title: "Privacy", color: .blue) {
                    // Handle privacy
                }
                
                Divider()
                    .padding(.leading, 44)
                
                SettingsRow(icon: "gear", title: "Preferences", color: .gray) {
                    // Handle preferences
                }
                
                Divider()
                    .padding(.leading, 44)
                
                SettingsRow(icon: "questionmark.circle.fill", title: "Help & Support", color: .green) {
                    // Handle help
                }
                
                Divider()
                    .padding(.leading, 44)
                
                SettingsRow(icon: "arrow.right.square.fill", title: "Sign Out", color: .red) {
                    // Handle sign out
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
}

// MARK: - Supporting Views
struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
        )
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
                    .frame(width: 24)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Image Picker (Placeholder)
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    ProfileView()
}