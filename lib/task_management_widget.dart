import 'package:flutter/material.dart';

class TaskManagementWidget extends StatelessWidget {

  final ValueNotifier<List<Task>> tasksNotifier = ValueNotifier([
    Task(id: '1', title: 'Complete Flutter assignment', isCompleted: false),
    Task(id: '2', title: 'Review Clean Architecture concepts', isCompleted: true),
    Task(id: '3', title: 'Practice widget animations', isCompleted: false),
    Task(id: '4', title: 'Build mini app catalog', isCompleted: false),
      Task(id: '4', title: 'Build mini app taps', isCompleted: false),
        Task(id: '4', title: 'Build mini app taps2', isCompleted: false),
  ]);

  TaskManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
        backgroundColor: Colors.blue[600],
      ),
      body: ValueListenableBuilder<List<Task>>(
        valueListenable: tasksNotifier,
        builder: (context, tasks, _) {
          return ReorderableListView.builder(
            itemCount: tasks.length,
            onReorder: (oldIndex, newIndex) {
              final updatedTasks = [...tasks];
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final Task item = updatedTasks.removeAt(oldIndex);
              updatedTasks.insert(newIndex, item);

              tasksNotifier.value = updatedTasks;
            },
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: Text('Are you sure you want to delete "${task.title}"?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (direction) {
                  final deletedTask = task;
                  final deletedIndex = index;

                  final updatedTasks = [...tasks];
                  updatedTasks.removeAt(index);
                  tasksNotifier.value = updatedTasks;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('"${deletedTask.title}" deleted'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          final undoTasks = [...tasksNotifier.value];
                          undoTasks.insert(deletedIndex, deletedTask);
                          tasksNotifier.value = undoTasks;
                        },
                      ),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: const Icon(Icons.drag_handle),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        final updatedTasks = [...tasks];
                        updatedTasks[index] = task.copyWith(isCompleted: value ?? false);
                        tasksNotifier.value = updatedTasks;
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Task {
  final String id;
  final String title;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  Task copyWith({String? id, String? title, bool? isCompleted}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
