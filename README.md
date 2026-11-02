# 📱 Flutter Lab Class (`Flutter_lab_class`)

A comprehensive **Flutter & Dart** coursework and lab repository featuring interactive UI components, state management with Provider, authentication screens, and structured laboratory exercises.

---

## 🎯 Lab 1: My First Flutter App (`LabFirstAppScreen`)

Implements the cross-platform version of the mobile lab demonstration:
- **Title**: `My First Android App` (rendered with Flutter Material 3)
- **Input**: TextField (`hint: "Enter your name"`)
- **Buttons**:
  - `Submit`: Displays `Hello, <name>!` and shows a SnackBar.
  - `Clear`: Clears both the input and the greeting label.
- **Empty validation**: Prompts the user with `Please enter your name` if empty.

---

## 🏗️ Project Architecture

```
lib/
├── main.dart                          # App entry point & MultiProvider initialization
├── models/
│   └── task_model.dart                # Data models
├── providers/                         # Reactive State Management
│   ├── auth_provider.dart             # Authentication state
│   ├── settings_provider.dart         # Theme and user preferences
│   └── task_provider.dart             # Course task CRUD
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart          # Login with form validation
│   │   └── signup_screen.dart         # Registration
│   ├── lab_first_app_screen.dart      # Lab 1 interactive demo
│   ├── home_screen.dart               # Dashboard
│   ├── explore_screen.dart            # Course catalog
│   ├── tasks_screen.dart              # Task manager
│   ├── course_detail_screen.dart      # Course detail view
│   ├── profile_screen.dart            # User profile
│   └── settings_screen.dart           # App settings
├── widgets/
│   └── stat_card.dart                 # Reusable dashboard metric card
└── labs/                              # Course Lab Syllabus & Documentation
    ├── Lab_01_Basics_and_First_App/
    ├── Lab_02_Widgets_and_Layouts/
    ├── Lab_03_State_Management_Provider/
    ├── Lab_04_Navigation_and_Routing/
    └── Lab_05_HTTP_REST_API/
```

---

## 🚀 How to Run

1. Make sure Flutter SDK is installed and added to your `PATH`.
2. Open this folder in VS Code or Android Studio:
   ```
   D:\Desktop\Mobile App\Flutter_lab_class
   ```
3. Fetch dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```
