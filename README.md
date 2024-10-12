
# Real-Time Chat App using Flutter

A simple real-time chat application built using Flutter that allows users to send and receive messages instantly. The app leverages Firebase for user authentication and real-time messaging, providing a seamless chat experience.

## Features
- User authentication: sign up, sign in and sign out with firebase authentication (Google and email/password support).
- Real-time messaging: Messages are sent and received in real time using Cloud Firestore.
- Notifications: Firebase Cloud Messaging (FCM) is used to send and receive notifications for new messages.
- Basic chat functionality with individual users

## Tech Stack
- **Frontend**: Flutter (Dart)
- Firebase: Backend services(Firebase Authentication, Cloud Firestore, Firebase Cloud Messaging (FCM))

## Getting Started
 Follow these instructions to set up and run the project on your local machine.

Prerequisites
- Flutter SDK
- Firebase Account
- Android Studio


    
## Screenshots 
share some screen shot in future 


## Project Structure
```bash
lib/
├── main.dart                 # App entry point
├── screens/
│   ├── login_screen.dart      # User authentication screen
│   ├── chat_screen.dart       # Chat interface screen
├── services/
│   ├── auth_service.dart      # Handles user authentication
│   ├── database_service.dart  # Firestore database interactions
│   ├── notification_service.dart  # Firebase push notifications
└── widgets/
    ├── message_bubble.dart    # Widget for displaying chat bubbles
    └── input_field.dart       # Widget for typing and sending messages










