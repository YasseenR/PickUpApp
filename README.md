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
