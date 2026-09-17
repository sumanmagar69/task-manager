class Task {
  final int? id;
  final String title;
  final String date;
  final String level;
  final bool completed;
  const Task({this.id, required this.title, required this.date, required this.level, required this.completed});
  Map<String, dynamic> toMap() => {'id': id, 'title': title, 'date': date, 'level': level, 'completed': completed ? 1 : 0};
  factory Task.fromMap(Map<String, dynamic> map) => Task(id: map['id'] as int?, title: map['title'] as String, date: map['date'] as String, level: map['level'] as String, completed: map['completed'] == 1);
  Task copyWith({bool? completed}) => Task(id: id, title: title, date: date, level: level, completed: completed ?? this.completed);
}
