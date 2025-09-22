//
//  EventCreationView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI
import FirebaseFirestore


enum EventCreationState {
    case welcome
    case details
    case customization
}

struct EventCreationView: View {
    @State private var currentState: EventCreationState = .welcome
    @State private var eventData = EventCreationModel()
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    var body: some View {
        NavigationView {
            
            Group {
                switch currentState {
                case .welcome:
                    welcomeView
                case .details:
                    detailsView
                case .customization:
                    customizationView
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
    
    private var welcomeView: some View {
        VStack(spacing: 40) {
            Spacer()
            Image(systemName: "person.3.fill")
                .font(.system(size: 60))
                .foregroundColor(.cherryRed)
            VStack {
                Text("Host a Game")
                    .font(.system(size: 30))
                    .bold()
                Text("Host your match, invite players, and play your way.")
                    .font(.caption)
            }
            VStack(spacing: 16) {
                BenefitRow(icon: "person.2.fill", title: "Connect Players", description: "Bring together players of all skill levels")
                BenefitRow(icon: "calendar.badge.plus", title: "Schedule Games", description: "Set your preferred time and location")
                BenefitRow(icon: "star.fill", title: "Build Community", description: "Create lasting connections through sports")
                
            }
            .padding(.horizontal, 25)
            Spacer()
            
            Button(action: {
                // Add a new document with a generated ID
                currentState = .details

            } ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.cherryRed)
                        .frame(height: 60)
                        .overlay(
                            Text("Start Creating Game")
                                .foregroundStyle(.white)
                                .bold()
                        )
                        .padding(30)
                }
            }
            
            
        }
    }
    
    private var detailsView: some View {
        VStack {
            Text("Event Creation Page")
            ScrollView {
                VStack {
                    Text("Choose the sport")
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(Sport.allCases, id: \.self) { sport in
                            SportCard(sport: sport, isSelected: eventData.sport == sport, action: {eventData.sport = sport})
                        }
                    }
                    .padding()
                    
                    Text("Choose the skill level")
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(SkillLevel.allCases, id: \.self) {skill in
                            SkillLevelCard(skillLevel: skill, isSelected: eventData.skillLevel == skill, action: {eventData.skillLevel = skill})
                        }
                    }
                    .padding()
                    
                    // Date and Time
                   Text("Choose the Date")
                   
                   VStack {
                       
                       DatePicker("Event Date", selection: $eventData.eventDate, displayedComponents: .date)
                           .datePickerStyle(CompactDatePickerStyle())
                           .padding(.horizontal, 8)
                           .padding(.vertical, 8)
                       Divider()
                       DatePicker("Start Time", selection: $eventData.startTime, displayedComponents: .hourAndMinute)
                           .datePickerStyle(CompactDatePickerStyle())
                           .padding(.horizontal, 8)
                       Divider()
                       DatePicker("End Time", selection: $eventData.endTime, displayedComponents: .hourAndMinute)
                           .datePickerStyle(CompactDatePickerStyle())
                           .padding(.horizontal, 8)
                           .padding(.vertical, 8)
                           
                   }
                   .background(
                       RoundedRectangle(cornerRadius: 12)
                           .fill(Color(.systemGray6))
                   )
                   .padding()
                    
                    
                    TextField("Enter location (e.g., Pearson Hall 3rd Floor Gym)", text: $eventData.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                        )
                        .padding()
                    
                    HStack {
                        Text("\(eventData.maxAttendees) players")
                            .font(.headline)
                            .foregroundColor(.cherryRed)
                            .padding(8)
                        
                        Spacer()
                        
                        Stepper("", value: $eventData.maxAttendees, in: 2...50)
                            .labelsHidden()
                            .padding(8)
                    }

                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                    .padding()
                    
                    Button(action: {
                            withAnimation {
                                print(eventData)
                                currentState = .customization
                            }
                        }) {
                            HStack {
                                Text("Continue")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                
                                Image(systemName: "arrow.right")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.cherryRed)
                            )
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 20)
                }
            }

        }
    }
    
    var customizationView: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Event Title")
                    .font(.headline)
                
                TextField("Give your event a catchy name", text: $eventData.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(spacing: 12) {
                Text("Description")
                    .font(.headline)
                
                TextField("Tell players what to expect...", text: $eventData.description, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .lineLimit(3...6)
            }
            
            VStack(spacing: 12) {
                Text("Event Image")
                    .font(.headline)
                
                Button(action: {showingImagePicker = true} ) {
                    VStack(spacing: 12) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height:120)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                                .frame(height: 120)
                                .overlay(
                                    VStack(spacing: 8) {
                                        Image(systemName: "photo")
                                            .font(.title2)
                                            .foregroundColor(.secondary)
                    
                                        Text("Add Event Photo")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                )
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Button(action: {
                // Add a new document with a generated ID
                
                createEvent(eventData: eventData)
                currentState = .welcome
                

            } ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.cherryRed)
                        .frame(height: 60)
                        .overlay(
                            Text("Create Game")
                                .foregroundStyle(.white)
                                .bold()
                        )
                        .padding(30)
                }
            }
            
            
        }
    }
}



func action() {
    
}

struct SkillLevelCard: View {
    let skillLevel: SkillLevel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: skillLevel.icon)
                    .font(.title2)
                    .foregroundStyle(skillLevel.iconColor)
                Text("\(skillLevel.displayName)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(isSelected ? .white : .cherryRed)
            }
            .foregroundStyle(Color(.white))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? .cherryRed : Color(.systemGray6))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}

struct SportCard: View {
    let sport: Sport
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: sport.icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? .white : .cherryRed)
                Text("\(sport.displayName)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(isSelected ? .white : .cherryRed)
            }
            .foregroundStyle(Color(.white))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? .cherryRed : Color(.systemGray6))
            )
            
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BenefitRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.cherryRed)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}



enum Sport: String, CaseIterable, Codable {
    case basketball = "Basketball"
    case volleyball = "Volleyball"
    case badminton = "Badminton"
    case pickleball = "Pickleball"
    case tennis = "Tennis"
    case soccer = "Soccer"
    
    var displayName: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .basketball: return "figure.basketball"
        case .volleyball: return "figure.volleyball"
        case .badminton: return "figure.badminton"
        case .pickleball: return "figure.pickleball"
        case .tennis: return "figure.tennis"
        case .soccer: return "figure.indoor.soccer"
        }
    }
}

enum SkillLevel: String, CaseIterable, Codable {
    case allLevels = "All Levels"
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    
    var displayName: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .allLevels: return "person.3.fill"
        case .beginner: return "medal.fill"
        case .intermediate: return "medal.fill"
        case .advanced: return "medal.fill"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .allLevels: return .silver
        case .beginner: return .bronze
        case .intermediate: return .gold
        case .advanced: return .success
        }
    }
}

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
        try FirestoreManager.shared.db.collection("users").addDocument(from: eventData) { error in
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
    EventCreationView()
}
