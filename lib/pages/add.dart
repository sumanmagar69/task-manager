import 'package:flutter/material.dart';
import 'package:task_manager/models/database_helper.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});
  @override State<AddTaskPage> createState() => _AddTaskPageState();
}
class _AddTaskPageState extends State<AddTaskPage> {
  final _title = TextEditingController(); final _date = TextEditingController(); String? _priority;
  final _priorities = ['High', 'Medium', 'Low'];
  Future<void> _selectDate() async { final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100)); if (picked != null) setState(() => _date.text = '${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}'); }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Add Task')), body: Padding(padding: const EdgeInsets.all(24), child: Column(children: [TextField(controller: _title, decoration: const InputDecoration(labelText: 'Title')), const SizedBox(height: 16), TextField(controller: _date, readOnly: true, onTap: _selectDate, decoration: const InputDecoration(labelText: 'Date', suffixIcon: Icon(Icons.calendar_today))), const SizedBox(height: 16), DropdownButtonFormField<String>(value: _priority, decoration: const InputDecoration(labelText: 'Priority'), items: _priorities.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(), onChanged: (value) => setState(() => _priority = value)), const SizedBox(height: 24), SizedBox(width: double.infinity, child: FilledButton(onPressed: () async { if (_title.text.trim().isEmpty || _date.text.isEmpty || _priority == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all fields.'))); return; } await DatabaseHelper().insertTask(Task(title: _title.text.trim(), date: _date.text, level: _priority!, completed: false)); if (mounted) Navigator.pop(context); }, child: const Text('Add')))])));
  @override void dispose() { _title.dispose(); _date.dispose(); super.dispose(); }
}
