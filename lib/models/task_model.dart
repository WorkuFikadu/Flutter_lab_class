enum TaskPriority { low, medium, high }

class TaskModel {
  final String id;
  final String title;
  final String category;
  final TaskPriority priority;
  final DateTime createdAt;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    this.priority = TaskPriority.medium,
    DateTime? createdAt,
    this.isCompleted = false,
  }) : createdAt = createdAt ?? DateTime.now();

  TaskModel copyWith({
    String? id,
    String? title,
    String? category,
    TaskPriority? priority,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
