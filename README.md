# Task Manager

A Flutter task manager application with local SQLite persistence.

## Features

- Add tasks with a title, date, and priority
- Update or delete tasks
- Mark tasks complete with a checkbox
- View completed task history
- Clear all stored tasks from Settings
- Local SQLite database persistence

## Run

```bash
flutter pub get
flutter run
```

## Structure

- `lib/main.dart` — app routes and active task list
- `lib/models/task.dart` — task model
- `lib/models/database_helper.dart` — SQLite database access
- `lib/pages/add.dart` — add task form
- `lib/pages/update.dart` — update and delete form
- `lib/pages/history.dart` — completed tasks
- `lib/pages/settings.dart` — application settings
