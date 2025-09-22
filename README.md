🏐 Volleyball Pickup App
An iOS app built with SwiftUI and Firebase that helps players find, join, and host local volleyball games — supporting Grass, Beach, and Indoor formats. Inspired by apps like Plei and OpenSport, this MVP is designed for volleyball but built with scalability to expand into other activities like dance sessions or pickup sports.
✨ Features
🔐 Apple Sign-In authentication
📍 Location-based game discovery (only see nearby events)
📝 Host games (with verification to prevent spam)
👥 Join or waitlist for games
💬 In-app chat for joined game participants
🔔 Push notifications for reminders and chat updates
📶 Offline support (view saved/joined games & history)
⭐ Rate hosts after games
🎨 Dark mode UI with a clean volleyball-inspired palette (black, red, green accents)
🛠️ Tech Stack
Frontend: Swift, SwiftUI, Combine
Backend: Firebase
Authentication (Apple Sign-In)
Firestore (game data, chat, ratings)
Cloud Storage (event images, user assets)
Cloud Functions (notifications, verification logic)
Firebase Cloud Messaging (push notifications)
Location: CoreLocation + GeoFirestore
Architecture: MVVM + service layer abstraction
📱 Core Screens
Onboarding & Apple Sign-In
Home Feed / Nearby Games
Game Details (location, time, skill, cost, players)
Create Game Flow (for verified hosts)
Game Chat
Profile & History
My Games (Upcoming & Past)
🚀 Getting Started
Prerequisites
Xcode 15+
iOS 17+ target
Swift 5.9+
A Firebase project set up with:
Authentication (Apple Sign-In)
Firestore Database
Cloud Functions
Firebase Cloud Messaging
Installation
Clone the repository:
git clone https://github.com/your-username/volleyball-pickup-app.git
cd volleyball-pickup-app
Install dependencies with Swift Package Manager (Firebase SDKs).
Configure your Firebase project:
Add your GoogleService-Info.plist to the Xcode project.
Enable Apple Sign-In under Firebase Authentication.
Run the app on the iOS simulator or device.
🔮 Future Roadmap
🌐 Expand to other activities (dance, soccer, basketball, etc.)
🏆 Host reputation system & achievements
🎟️ Event ticketing & premium features
🖼️ Event photo galleries & media sharing
🤝 Partnerships with local gyms & organizers
