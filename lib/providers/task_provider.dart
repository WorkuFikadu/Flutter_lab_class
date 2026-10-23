import 'package:flutter/foundation.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [
    TaskModel(
      id: '1',
      title: 'Complete Flutter Lab Assignment',
      category: 'Study',
      priority: TaskPriority.high,
      isCompleted: true,
    ),
    TaskModel(
      id: '2',
      title: 'Review Computer Science Exam Notes',
      category: 'Study',
      priority: TaskPriority.high,
      isCompleted: false,
    ),
    TaskModel(
      id: '3',
      title: 'Push updated project code to GitHub',
      category: 'Work',
      priority: TaskPriority.medium,
      isCompleted: true,
    ),
    TaskModel(
      id: '4',
      title: 'Test app on Android Virtual Device',
      category: 'Work',
      priority: TaskPriority.low,
      isCompleted: false,
    ),
    TaskModel(
      id: '5',
      title: 'Team meeting at Jimma University café',
      category: 'Personal',
      priority: TaskPriority.medium,
      isCompleted: false,
    ),
  ];

  String _selectedCategory = 'All';

  List<TaskModel> get tasks {
    if (_selectedCategory == 'All') {
      return List.unmodifiable(_tasks);
    }
    return List.unmodifiable(
      _tasks.where((t) => t.category == _selectedCategory),
    );
  }

  String get selectedCategory => _selectedCategory;

  int get totalCount => _tasks.length;
  int get completedCount => _tasks.where((t) => t.isCompleted).length;
  int get pendingCount => _tasks.where((t) => !t.isCompleted).length;

  double get completionProgress {
    if (_tasks.isEmpty) return 0.0;
    return completedCount / totalCount;
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void addTask({
    required String title,
    required String category,
    TaskPriority priority = TaskPriority.medium,
  }) {
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      category: category,
      priority: priority,
    );
    _tasks.insert(0, newTask);
    notifyListeners();
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
