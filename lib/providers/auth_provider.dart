// lib/providers/auth_provider.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  // 🔥 Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  
  // 📦 State variables
  User? _user;
  bool _isLoading = false;
  
  // Getters (এই ভেরিয়েবলগুলোর মান বাইরে থেকে পড়তে পারবে কিন্তু পরিবর্তন করতে পারবে না)
  User? get user => _user;
  bool get isLoading => _isLoading;
  
  // 🏗️ Constructor: অ্যাপ start হওয়ার সাথে সাথে user check করে
  AuthProvider() {
    _checkUserStatus();
  }
  
  // 👤 ইউজারের লগইন স্টেট চেক করা
  void _checkUserStatus() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners(); // UI update করার জন্য notify করে
    });
  }
  
  // 📧 Email/Password এ Sign Up
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // 1. Firebase Auth এ ইউজার তৈরি করা
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // 2. Firestore এ ইউজারের ডিটেইল সেভ করা
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        phone: phone,
        role: 'user',
        createdAt: DateTime.now(),
      );
      
      await _firestoreService.saveUser(userModel);
      
      _isLoading = false;
      notifyListeners();
      return true;
      
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Sign up error: $e");
      return false;
    }
  }
  
  // 📧 Email/Password এ Sign In
  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      _isLoading = false;
      notifyListeners();
      return true;
      
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // 🚪 Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}