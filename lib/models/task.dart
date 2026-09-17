import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  const Task({required this.id, required this.title, required this.description, required this.completed, required this.createdAt});
  final String id;
  final String title;
  final String description;
  final bool completed;
  final DateTime createdAt;

  factory Task.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    final timestamp = data['createdAt'];
    return Task(id: document.id, title: data['title'] as String? ?? '', description: data['description'] as String? ?? '', completed: data['completed'] as bool? ?? false, createdAt: timestamp is Timestamp ? timestamp.toDate() : DateTime.now());
  }

  Map<String, dynamic> toMap() => {'title': title, 'description': description, 'completed': completed, 'createdAt': Timestamp.fromDate(createdAt)};
  Task copyWith({String? title, String? description, bool? completed}) => Task(id: id, title: title ?? this.title, description: description ?? this.description, completed: completed ?? this.completed, createdAt: createdAt);
}
