import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  static const String _tasksStorageKey = 'app_saved_tasks_v1';

  List<TaskModel> _tasks = [];
  String _selectedCategory = 'All';
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  TaskProvider() {
    _loadTasks();
  }

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

  Future<void> _loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedData = prefs.getString(_tasksStorageKey);

      if (savedData != null && savedData.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(savedData);
        _tasks = decoded.map((item) => TaskModel.fromJson(item)).toList();
      } else {
        _tasks = _getDefaultTasks();
        await _saveTasksToPrefs();
      }
    } catch (e) {
      debugPrint('Error loading tasks from SharedPreferences: $e');
      _tasks = _getDefaultTasks();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveTasksToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(_tasks.map((t) => t.toJson()).toList());
      await prefs.setString(_tasksStorageKey, encoded);
    } catch (e) {
      debugPrint('Error saving tasks to SharedPreferences: $e');
    }
  }

  Future<void> addTask({
    required String title,
    required String category,
    TaskPriority priority = TaskPriority.medium,
  }) async {
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      category: category,
      priority: priority,
    );
    _tasks.insert(0, newTask);
    notifyListeners();
    await _saveTasksToPrefs();
  }

  Future<void> toggleTask(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
      await _saveTasksToPrefs();
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
    await _saveTasksToPrefs();
  }

  List<TaskModel> _getDefaultTasks() {
    return [
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
  }
}
