import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';

class LoadingPage extends StatefulWidget { const LoadingPage({super.key}); @override State<LoadingPage> createState() => _LoadingPageState(); }
class _LoadingPageState extends State<LoadingPage> { @override void initState() { super.initState(); Timer(const Duration(seconds: 1), () { if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MyHomePage())); }); } @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.task_alt, size: 120, color: Colors.green), SizedBox(height: 16), Text('Task Manager', style: TextStyle(fontSize: 30))]))); }
