import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> _collection(String uid) => _firestore.collection('users').doc(uid).collection('tasks');
  Stream<List<Task>> watchTasks(String uid) => _collection(uid).orderBy('createdAt', descending: true).snapshots().map((snapshot) => snapshot.docs.map(Task.fromDocument).toList());
  Future<void> createTask(String uid, String title, String description) => _collection(uid).add({'title': title.trim(), 'description': description.trim(), 'completed': false, 'createdAt': FieldValue.serverTimestamp()});
  Future<void> updateTask(String uid, Task task) => _collection(uid).doc(task.id).update(task.toMap());
  Future<void> deleteTask(String uid, String taskId) => _collection(uid).doc(taskId).delete();
}
