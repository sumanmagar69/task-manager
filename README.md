# Firebase Task Manager

A complete multi-screen Flutter task manager built with Firebase Authentication, Cloud Firestore, Provider, and dynamic Light/Dark themes.

## Requirements implemented

- **Firebase Auth:** email/password Sign In, Sign Up, Sign Out, and persistent `authStateChanges` screen protection.
- **Firestore CRUD:** tasks are stored under `users/{uid}/tasks`; the app creates, reads through a real-time stream, updates, and deletes tasks.
- **Provider:** `AuthProvider`, `TaskProvider`, and `ThemeProvider` keep business logic and data access out of widgets.
- **Themes:** custom Material 3 light and dark `ThemeData`, with a persistent toggle in the navigation drawer.
- **UX:** task filters, validation, edit dialog, swipe-to-delete confirmation, empty/error states, and responsive Material UI.

## Firebase setup

1. Create a Firebase project at https://console.firebase.google.com.
2. Enable **Authentication → Sign-in method → Email/Password**.
3. Create a **Cloud Firestore** database.
4. Install the tools:

```bash
npm install -g firebase-tools
firebase login
dart pub global activate flutterfire_cli
```

5. From this repository root, generate platform configuration:

```bash
flutterfire configure
```

This creates `lib/firebase_options.dart` and native Firebase configuration files. For production/platform-specific initialization, update `main.dart` to use the generated options:

```dart
import 'firebase_options.dart';
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

6. Add these Firestore security rules:

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/tasks/{taskId} {
      allow read, write: if request.auth != null
        && request.auth.uid == userId;
    }
  }
}
```

## Run and verify

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Create an account, add a task, edit it, toggle completion, test swipe-to-delete, sign out/in, and switch the theme from the drawer.

## Screenshots / recording

Run the configured app and add actual captures to `screenshots/` before submission. Recommended evidence:

```markdown
![Sign in](screenshots/sign-in.png)
![Firestore task list](screenshots/task-list.png)
![Edit and delete](screenshots/edit-delete.png)
![Dark mode](screenshots/dark-mode.png)
```

## Structure

```text
lib/
├── models/task.dart
├── services/auth_service.dart
├── services/task_service.dart
├── providers/auth_provider.dart
├── providers/task_provider.dart
├── providers/theme_provider.dart
├── theme/app_theme.dart
├── screens/auth_screen.dart
├── screens/home_screen.dart
└── main.dart
```
