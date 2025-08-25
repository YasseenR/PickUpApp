//
//  EventsPageView.swift
//  PickUp
//
//  Created by Yasseen Rouni on 8/21/25.
//

import SwiftUI

struct EventsPageView: View {
    @State private var selectedFilter: EventFilter = .all
    @State private var searchText = ""
    @State private var showingFilters = false
    
    // Mock data - replace with actual events
    @State private var events: [EventModel] = [
        EventModel(
            host: "Temple University Athletics",
            title: "Friday Night Volleyball",
            date: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date(),
            startTime: Calendar.current.date(bySettingHour: 18, minute: 30, second: 0, of: Date()) ?? Date(),
            endTime: Calendar.current.date(bySettingHour: 20, minute: 30, second: 0, of: Date()) ?? Date(),
            location: "Pearson Hall 3rd Floor Gym",
            sport: "Volleyball",
            skillLevel: .allLevels,
            maxAttendees: 20,
            currentAttendees: 12,
            isOfficial: true,
            description: "Join us for an exciting evening of volleyball! All skill levels welcome. Equipment provided.",
            imageName: "volleyball"
        ),
        EventModel(
            host: "Tharani Kannan",
            title: "Weekend Basketball Pickup",
            date: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date(),
            startTime: Calendar.current.date(bySettingHour: 15, minute: 30, second: 0, of: Date()) ?? Date(),
            endTime: Calendar.current.date(bySettingHour: 17, minute: 30, second: 0, of: Date()) ?? Date(),
            location: "Pearson Hall 3rd Floor Gym",
            sport: "Basketball",
            skillLevel: .intermediate,
            maxAttendees: 15,
            currentAttendees: 8,
            isOfficial: false,
            description: "Intermediate level basketball game. Bring your A-game and let's have some fun!",
            imageName: "basketball"
        ),
        EventModel(
            host: "Campus Rec Center",
            title: "Soccer Skills & Scrimmage",
            date: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(),
            startTime: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date()) ?? Date(),
            endTime: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date()) ?? Date(),
            location: "Outdoor Soccer Field",
            sport: "Soccer",
            skillLevel: .beginner,
            maxAttendees: 25,
            currentAttendees: 18,
            isOfficial: true,
            description: "Perfect for beginners! Learn basic skills and enjoy a friendly scrimmage.",
            imageName: "soccer"
        )
    ]
    
    var filteredEvents: [EventModel] {
        var filtered = events
        
        // Apply search filter
        if !searchText.isEmpty {
            filtered = filtered.filter { event in
                event.title.localizedCaseInsensitiveContains(searchText) ||
                event.sport.localizedCaseInsensitiveContains(searchText) ||
                event.location.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Apply category filter
        switch selectedFilter {
        case .all:
            break
        case .official:
            filtered = filtered.filter { $0.isOfficial }
        case .unofficial:
            filtered = filtered.filter { !$0.isOfficial }
        case .today:
            filtered = filtered.filter { Calendar.current.isDateInToday($0.date) }
        case .thisWeek:
            let weekFromNow = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()) ?? Date()
            filtered = filtered.filter { $0.date <= weekFromNow }
        }
        
        // Sort by date (closest first)
        return filtered.sorted { $0.date < $1.date }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header Section
                headerSection
                
                // Search and Filter Section
                searchAndFilterSection
                
                // Events List
                if filteredEvents.isEmpty {
                    emptyStateView
                } else {
                    eventsList
                }
            }
            .navigationTitle("Events")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingFilters.toggle() }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .sheet(isPresented: $showingFilters) {
            FilterView(selectedFilter: $selectedFilter)
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Temple University")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("Find your next game")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Quick stats
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(filteredEvents.count)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Text("Events")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .padding(.bottom, 16)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Search and Filter Section
    private var searchAndFilterSection: some View {
        VStack(spacing: 16) {
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search events, sports, or locations...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal, 20)
            
            // Filter Chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(EventFilter.allCases, id: \.self) { filter in
                        FilterChip(
                            title: filter.displayName,
                            isSelected: selectedFilter == filter,
                            action: { selectedFilter = filter }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 16)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Events List
    private var eventsList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredEvents) { event in
                    EventCard(event: event)
                        .padding(.horizontal, 20)
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text("No events found")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Try adjusting your filters or check back later for new events")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
}

// MARK: - Event Card
struct EventCard: View {
    let event: EventModel
    @State private var showingEventDetails = false
    
    var body: some View {
        Button(action: { showingEventDetails.toggle() }) {
            VStack(alignment: .leading, spacing: 0) {
                // Event Image and Badge
                ZStack(alignment: .topLeading) {
                    // Placeholder image - replace with actual images
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 160)
                        .overlay(
                            Image(systemName: "sportscourt.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                        )
                    
                    // Official/Unofficial Badge
                    HStack(spacing: 4) {
                        Image(systemName: event.isOfficial ? "checkmark.seal.fill" : "person.2.fill")
                            .font(.caption)
                        
                        Text(event.isOfficial ? "Official" : "Unofficial")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(event.isOfficial ? Color.green.opacity(0.9) : Color.blue.opacity(0.9))
                    )
                    .foregroundColor(.white)
                    .padding(12)
                }
                
                // Event Details
                VStack(alignment: .leading, spacing: 12) {
                    // Title and Sport
                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        HStack {
                            Text(event.sport)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.blue)
                            
                            Spacer()
                            
                            // Skill Level Badge
                            Text(event.skillLevel.rawValue)
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule()
                                        .fill(Color(event.skillLevel.color).opacity(0.2))
                                )
                                .foregroundColor(Color(event.skillLevel.color))
                        }
                    }
                    
                    // Date and Time
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.secondary)
                            .frame(width: 16)
                        
                        Text(event.formattedDateTime)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                    
                    // Location
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.secondary)
                            .frame(width: 16)
                        
                        Text(event.location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    
                    // Host and Attendees
                    HStack {
                        HStack(spacing: 4) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.secondary)
                                .font(.caption)
                            
                            Text(event.host)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        // Attendee Status
                        HStack(spacing: 4) {
                            Image(systemName: "person.2.fill")
                                .foregroundColor(event.isFull ? .red : .green)
                                .font(.caption)
                            
                            Text(event.attendeeStatus)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(event.isFull ? .red : .green)
                        }
                    }
                }
                .padding(16)
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingEventDetails) {
            EventDetailView(event: event)
        }
    }
}

// MARK: - Filter Chip
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.blue : Color(.systemGray6))
                )
                .foregroundColor(isSelected ? .white : .primary)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Event Filter
enum EventFilter: CaseIterable {
    case all, official, unofficial, today, thisWeek
    
    var displayName: String {
        switch self {
        case .all: return "All"
        case .official: return "Official"
        case .unofficial: return "Unofficial"
        case .today: return "Today"
        case .thisWeek: return "This Week"
        }
    }
}

// MARK: - Filter View
struct FilterView: View {
    @Binding var selectedFilter: EventFilter
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(EventFilter.allCases, id: \.self) { filter in
                    Button(action: {
                        selectedFilter = filter
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text(filter.displayName)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if selectedFilter == filter {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Filter Events")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Event Detail View (Placeholder)
struct EventDetailView: View {
    let event: EventModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Placeholder for detailed event view
                    Text("Event Details for: \(event.title)")
                        .font(.title)
                        .padding()
                    
                    Text("This would show full event details, join button, etc.")
                        .padding()
                }
            }
            .navigationTitle("Event Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    EventsPageView()
}
