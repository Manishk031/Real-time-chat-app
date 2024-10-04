
# Real-Time Chat App using Flutter

A simple real-time chat application built using Flutter that allows users to send and receive messages instantly. The app leverages Firebase for user authentication and real-time messaging, providing a seamless chat experience.

## Features
- User authentication (Sign in/Sign up)
- Real-time messaging using Firebase
- Notifications for new messages
- Basic chat functionality with individual users

## Tech Stack
- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Authentication, Firestore)

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

## Screenshots
*(You can add relevant screenshots here to showcase your app interface)*

![Chat Screen](link_to_image)


