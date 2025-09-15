//
//  EventCreationView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct EventCreationView: View {
    @State private var currentStep: CreationStep = .welcome
    @State private var eventData = EventCreationData()
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    enum CreationStep: Int, CaseIterable {
        case welcome = 0
        case details = 1
        case customization = 2
        
        var title: String {
            switch self {
            case .welcome: return "Create Event"
            case .details: return "Event Details"
            case .customization: return "Final Details"
            }
        }
        
        var progress: Double {
            return Double(self.rawValue) / Double(CreationStep.allCases.count - 1)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Progress Bar
                if currentStep != .welcome {
                    progressBar
                }
                
                // Content
                Group {
                    switch currentStep {
                    case .welcome:
                        welcomeStep
                    case .details:
                        detailsStep
                    case .customization:
                        customizationStep
                    }
                }
                .animation(.easeInOut, value: currentStep)
            }
            .navigationTitle(currentStep.title)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if currentStep != .welcome {
                        Button("Back") {
                            withAnimation {
                                currentStep = CreationStep(rawValue: currentStep.rawValue - 1) ?? .welcome
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
    
    // MARK: - Progress Bar
    private var progressBar: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Step \(currentStep.rawValue) of \(CreationStep.allCases.count - 1)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(Int(currentStep.progress * 100))% Complete")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            ProgressView(value: currentStep.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .scaleEffect(x: 1, y: 2, anchor: .center)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
    }
    
    // MARK: - Welcome Step
    private var welcomeStep: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Hero Section
            VStack(spacing: 24) {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                }
                
                VStack(spacing: 12) {
                    Text("Create Your Event")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("Host a pickup game and bring your community together")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
            }
            
            // Benefits Section
            VStack(spacing: 16) {
                BenefitRow(icon: "person.2.fill", title: "Connect Players", description: "Bring together players of all skill levels")
                BenefitRow(icon: "calendar.badge.plus", title: "Schedule Games", description: "Set your preferred time and location")
                BenefitRow(icon: "star.fill", title: "Build Community", description: "Create lasting connections through sports")
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // Create Event Button
            Button(action: {
                withAnimation {
                    currentStep = .details
                }
            }) {
                HStack {
                    Text("Start Creating Event")
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
                        .fill(Color.blue)
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
    }
    
    // MARK: - Details Step
    private var detailsStep: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Sport Selection
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Sport", icon: "sportscourt.fill")
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(Sport.allCases, id: \.self) { sport in
                            SportCard(
                                sport: sport,
                                isSelected: eventData.sport == sport,
                                action: { eventData.sport = sport }
                            )
                        }
                    }
                }
                
                // Skill Level
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Skill Level", icon: "star.fill")
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(EventModel.SkillLevel.allCases, id: \.self) { level in
                            SkillLevelCard(
                                level: level,
                                isSelected: eventData.skillLevel == level,
                                action: { eventData.skillLevel = level }
                            )
                        }
                    }
                }
                
                // Date and Time
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Date & Time", icon: "calendar")
                    
                    VStack(spacing: 16) {
                        DatePicker("Event Date", selection: $eventData.eventDate, displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                        
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Start Time")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                DatePicker("Start Time", selection: $eventData.startTime, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(CompactDatePickerStyle())
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("End Time")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                DatePicker("End Time", selection: $eventData.endTime, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(CompactDatePickerStyle())
                            }
                        }
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                }
                
                // Location
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Location", icon: "location.fill")
                    
                    TextField("Enter location (e.g., Pearson Hall 3rd Floor Gym)", text: $eventData.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Capacity
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Maximum Players", icon: "person.2.fill")
                    
                    HStack {
                        Text("\(eventData.maxAttendees) players")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Stepper("", value: $eventData.maxAttendees, in: 2...50)
                            .labelsHidden()
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                }
                
                // Continue Button
                Button(action: {
                    withAnimation {
                        currentStep = .customization
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
                            .fill(Color.blue)
                    )
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Customization Step
    private var customizationStep: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Event Title
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Event Title", icon: "textformat")
                    
                    TextField("Give your event a catchy name", text: $eventData.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Event Description
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Description", icon: "text.quote")
                    
                    TextField("Tell players what to expect...", text: $eventData.description, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3...6)
                }
                
                // Event Image
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Event Image", icon: "photo")
                    
                    Button(action: { showingImagePicker = true }) {
                        VStack(spacing: 12) {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 120)
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
                
                // Event Preview
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Preview", icon: "eye.fill")
                    
                    EventPreviewCard(eventData: eventData, selectedImage: selectedImage)
                }
                
                // Submit Button
                Button(action: {
                    // Handle event creation
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.headline)
                        
                        Text("Create Event")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.green)
                    )
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Supporting Views
struct BenefitRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
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

struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.headline)
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
        }
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
                    .foregroundColor(isSelected ? .white : .blue)
                
                Text(sport.displayName)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.blue : Color(.systemGray6))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SkillLevelCard: View {
    let level: EventModel.SkillLevel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: "star.fill")
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : Color(level.color))
                
                Text(level.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color(level.color) : Color(.systemGray6))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct EventPreviewCard: View {
    let eventData: EventCreationData
    let selectedImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Event Image
            ZStack(alignment: .topLeading) {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 120)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 120)
                        .overlay(
                            Image(systemName: "sportscourt.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.gray)
                        )
                }
                
                // Unofficial Badge
                HStack(spacing: 4) {
                    Image(systemName: "person.2.fill")
                        .font(.caption)
                    
                    Text("Unofficial")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Color.blue.opacity(0.9))
                )
                .foregroundColor(.white)
                .padding(12)
            }
            
            // Event Details
            VStack(alignment: .leading, spacing: 8) {
                Text(eventData.title.isEmpty ? "Your Event Title" : eventData.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                HStack {
                    Text(eventData.sport.displayName)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text(eventData.skillLevel.rawValue)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color(eventData.skillLevel.color).opacity(0.2))
                        )
                        .foregroundColor(Color(eventData.skillLevel.color))
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                        .frame(width: 16)
                    
                    Text(eventData.formattedDateTime)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.secondary)
                        .frame(width: 16)
                    
                    Text(eventData.location.isEmpty ? "Location" : eventData.location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                }
            }
            .padding(12)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}

// MARK: - Data Models
struct EventCreationData {
    var title: String = ""
    var description: String = ""
    var sport: Sport = .basketball
    var skillLevel: EventModel.SkillLevel = .allLevels
    var eventDate: Date = Date()
    var startTime: Date = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date()) ?? Date()
    var endTime: Date = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date()) ?? Date()
    var location: String = ""
    var maxAttendees: Int = 10
    
    var formattedDateTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        let combinedDate = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: startTime),
                                                minute: Calendar.current.component(.minute, from: startTime),
                                                second: 0,
                                                of: eventDate) ?? eventDate
        
        return "\(dateFormatter.string(from: combinedDate)) • \(timeFormatter.string(from: startTime)) - \(timeFormatter.string(from: endTime))"
    }
}

enum Sport: String, CaseIterable {
    case basketball = "Basketball"
    case volleyball = "Volleyball"
    case soccer = "Soccer"
    case tennis = "Tennis"
    case badminton = "Badminton"
    case tableTennis = "Table Tennis"
    
    var displayName: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .basketball: return "basketball.fill"
        case .volleyball: return "volleyball.fill"
        case .soccer: return "soccerball"
        case .tennis: return "tennis.racket"
        case .badminton: return "badminton.racket"
        case .tableTennis: return "table.tennis.paddle"
        }
    }
}

// MARK: - Image Picker (Reused from ProfileView)
// ImagePicker is already defined in ProfileView.swift

#Preview {
    EventCreationView()
}
