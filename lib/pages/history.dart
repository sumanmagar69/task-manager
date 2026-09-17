import 'package:flutter/material.dart';
import 'package:task_manager/models/database_helper.dart';
import 'package:task_manager/models/task.dart';

class HistoryPage extends StatefulWidget { const HistoryPage({super.key}); @override State<HistoryPage> createState() => _HistoryPageState(); }
class _HistoryPageState extends State<HistoryPage> { List<Task> _completed = []; @override void initState() { super.initState(); _load(); } Future<void> _load() async { final all = await DatabaseHelper().getTasks(); if (mounted) setState(() => _completed = all.where((task) => task.completed).toList()); } @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('History')), body: _completed.isEmpty ? const Center(child: Text('No completed tasks.')) : ListView.builder(itemCount: _completed.length, itemBuilder: (_, index) { final task = _completed[index]; return ListTile(title: Text(task.title, style: const TextStyle(decoration: TextDecoration.lineThrough)), subtitle: Text('${task.date} • ${task.level}'), trailing: IconButton(icon: const Icon(Icons.delete_forever, color: Colors.red), onPressed: () async { await DatabaseHelper().deleteTask(task.id!); _load(); })); })); }
}
