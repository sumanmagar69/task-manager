import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._service) { _subscription = _service.authStateChanges.listen((user) { _user = user; _loading = false; notifyListeners(); }); }
  final AuthService _service;
  late final StreamSubscription<User?> _subscription;
  User? _user;
  bool _loading = true;
  String? _error;
  User? get user => _user;
  bool get loading => _loading;
  String? get error => _error;
  Future<bool> signIn(String email, String password) => _run(() => _service.signIn(email, password));
  Future<bool> signUp(String email, String password) => _run(() => _service.signUp(email, password));
  Future<void> signOut() => _service.signOut();
  Future<bool> _run(Future<void> Function() operation) async { _error = null; try { await operation(); return true; } on FirebaseAuthException catch (error) { _error = error.message ?? 'Authentication failed'; } catch (_) { _error = 'Something went wrong'; } notifyListeners(); return false; }
  @override void dispose() { _subscription.cancel(); super.dispose(); }
}
