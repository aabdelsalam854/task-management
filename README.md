📋 Task Management with ValueNotifier

A simple Task Management app built with Flutter that demonstrates how to manage state efficiently using ValueNotifier and ValueListenableBuilder instead of setState, to improve performance and avoid rebuilding the entire UI.

✨ Features

✅ Add, update, and toggle tasks.

🔄 Reorder tasks with drag & drop.

🗑️ Delete tasks with swipe to dismiss and undo with Snackbar.

🎨 Clean UI with checkboxes to mark tasks as completed.

⚡ Uses ValueNotifier for efficient UI updates.

📂 Project Structure

Task Model → Represents a single task with id, title, and isCompleted.

TaskManagementWidget → Main widget containing the task list.

ValueNotifier / ValueListenableBuilder → Handles reactive state changes.

🚀 Getting Started

Clone the repository:

git clone https://github.com/your-username/task-management-valuenotifier.git


Install dependencies:

flutter pub get


Run the app:

flutter run

🛠️ How It Works

The tasks list is wrapped in a ValueNotifier.

UI listens to changes via ValueListenableBuilder.

When a task is added, removed, or updated, only the necessary widgets are rebuilt, not the entire screen.

📸 Screenshot (Optional)

(Add screenshots here if you have any)

💡 Why ValueNotifier?

Using setState would rebuild the whole widget tree unnecessarily.
ValueNotifier + ValueListenableBuilder only rebuilds the widgets that depend on the changed value → better performance.

📜 License

This project is licensed under the MIT License.