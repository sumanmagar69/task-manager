import 'package:flutter/material.dart';
import 'package:task_manager/models/database_helper.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/pages/add.dart';
import 'package:task_manager/pages/settings.dart';
import 'package:task_manager/pages/update.dart';
import 'package:task_manager/pages/loading.dart';
import 'package:task_manager/pages/history.dart';

void main() => runApp(const MyApp());

class RouteNames {
  static const home = '/';
  static const add = '/addtask';
  static const updateDelete = '/update_delete';
  static const history = '/history';
  static const settings = '/settings';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red), useMaterial3: true),
        initialRoute: RouteNames.home,
        routes: {
          RouteNames.home: (_) => const LoadingPage(),
          RouteNames.add: (_) => const AddTaskPage(),
          RouteNames.updateDelete: (context) => UpdateorDeleteTask(index: ModalRoute.of(context)!.settings.arguments as int),
          RouteNames.history: (_) => const HistoryPage(),
          RouteNames.settings: (_) => const SettingsPage(),
        },
      );
}

List<List<Object>> tasks = [];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final stored = await _databaseHelper.getTasks();
    final active = stored.where((task) => !task.completed).toList();
    if (!mounted) return;
    setState(() {
      _tasks = active;
      tasks = active.map((task) => <Object>[task.id!, task.title, task.date, task.level, task.completed]).toList();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Task Manager', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(onPressed: () => Navigator.pushNamed(context, RouteNames.history), icon: const Icon(Icons.history_outlined)),
            IconButton(onPressed: () => Navigator.pushNamed(context, RouteNames.settings), icon: const Icon(Icons.settings)),
          ],
        ),
        body: Column(children: [
          Padding(padding: const EdgeInsets.all(16), child: TextField(decoration: InputDecoration(hintText: 'Search tasks', filled: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(child: Text('No active tasks. Tap + to add one.'))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) => ListTile(
                      title: TextButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, RouteNames.updateDelete, arguments: index);
                          _loadTasks();
                        },
                        style: TextButton.styleFrom(alignment: Alignment.centerLeft, padding: EdgeInsets.zero),
                        child: Text(tasks[index][1].toString()),
                      ),
                      subtitle: Text('${tasks[index][2]} • ${tasks[index][3]}'),
                      trailing: Checkbox(
                        value: tasks[index][4] as bool,
                        onChanged: (value) async {
                          final task = _tasks[index];
                          await _databaseHelper.updateTask(task.copyWith(completed: value ?? false));
                          _loadTasks();
                        },
                      ),
                    ),
                  ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(onPressed: () async { await Navigator.pushNamed(context, RouteNames.add); _loadTasks(); }, child: const Icon(Icons.add)),
      );
}
