import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider(this._service, this.uid) { _subscription = _service.watchTasks(uid).listen((value) { _tasks = value; _error = null; notifyListeners(); }, onError: (_) { _error = 'Unable to load tasks. Check Firestore setup.'; notifyListeners(); }); }
  final TaskService _service;
  final String uid;
  late final StreamSubscription<List<Task>> _subscription;
  List<Task> _tasks = [];
  String? _error;
  List<Task> get tasks => List.unmodifiable(_tasks);
  String? get error => _error;
  Future<void> add(String title, String description) => _service.createTask(uid, title, description);
  Future<void> update(Task task, String title, String description) => _service.updateTask(uid, task.copyWith(title: title.trim(), description: description.trim()));
  Future<void> toggle(Task task) => _service.updateTask(uid, task.copyWith(completed: !task.completed));
  Future<void> remove(Task task) => _service.deleteTask(uid, task.id);
  @override void dispose() { _subscription.cancel(); super.dispose(); }
}
