# Todo App 📝

A fully functional Flutter todo application with persistent storage, popup menus, and intuitive user interface.

## Features ✨

### 🏠 Home Screen
- **Todo List Display**: View all your todos with numbered circle avatars
- **Persistent Storage**: All todos are saved using SharedPreferences
- **Visual Status**: Completed todos show with strikethrough text
- **Clean UI**: Modern design with custom colors and styling

### 📋 Todo Management
- **Add Todos**: Navigate to dedicated todo creation screen
- **Edit Todos**: Modify existing todos through popup menu
- **Delete Todos**: Remove todos with confirmation
- **Mark Complete/Incomplete**: Toggle completion status with visual feedback

### 🎯 Popup Menu Actions
- **Edit**: Modify todo text with dialog
- **Mark Complete/Incomplete**: Toggle completion status
- **Delete**: Remove todo from list
- **Visual Icons**: Color-coded icons for each action

### 🔧 Additional Features
- **Form Validation**: Ensures todos aren't empty
- **Loading States**: Shows progress indicators during operations
- **Bottom Navigation**: Easy navigation between screens
- **Bug-Free Code**: Includes Q3 screen with fixed common Flutter issues

## Screenshots 📱

The app includes:
- Modern teal-colored todo cards
- Numbered circle avatars for each todo
- Three-dot popup menus for actions
- Clean bottom navigation bar

## Getting Started 🚀

### Prerequisites
- Flutter SDK installed
- Android Studio or VS Code with Flutter extensions
- Android/iOS emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd todo_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```
4. **Add New dependency**
       ```bash
   flutter pub add dependency_name
   ```
## Usage 💡

### Adding a Todo
1. Tap the "add data" tab in bottom navigation
2. Enter your todo text in the form
3. Tap "Add list item" button
4. Returns to home screen with new todo added

### Managing Todos
1. Tap the three-dot menu (⋮) on any todo
2. Choose from:
   - **Edit**: Modify the todo text
   - **Mark Complete/Incomplete**: Toggle completion status
   - **Delete**: Remove the todo

### Navigation
- **Home**: View all todos
- **Add Data**: Create new todos
- **Q3**: User list screen (debugging example)

## Technical Features 🛠️

### Data Persistence
- Uses SharedPreferences for local storage
- Saves both todo text and completion status
- Automatic loading on app startup

### State Management
- StatefulWidget with setState()
- Proper async/await handling
- Form validation and error handling

### UI/UX Design
- Material Design components
- Custom color scheme
- Responsive layout
- Loading indicators

## Code Quality 📊

### Bug Fixes Included
The Q3 screen demonstrates fixes for common Flutter issues:
- Null safety handling
- ListView height constraints
- Data mutation problems
- Proper widget placement


