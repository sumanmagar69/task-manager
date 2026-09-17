import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'services/task_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); final theme = ThemeProvider(); await theme.load(); runApp(MultiProvider(providers: [ChangeNotifierProvider.value(value: theme), ChangeNotifierProvider(create: (_) => AuthProvider(AuthService()))], child: const TaskManagerApp())); }
class TaskManagerApp extends StatelessWidget { const TaskManagerApp({super.key}); @override Widget build(BuildContext context) => Consumer<AuthProvider>(builder: (_, auth, __) => MaterialApp(debugShowCheckedModeBanner: false, title: 'Task Manager', theme: AppTheme.light, darkTheme: AppTheme.dark, themeMode: context.watch<ThemeProvider>().mode, home: auth.loading ? const Scaffold(body: Center(child: CircularProgressIndicator())) : auth.user == null ? const AuthScreen() : ChangeNotifierProvider(create: (_) => TaskProvider(TaskService(), auth.user!.uid), child: const HomeScreen()))); }
