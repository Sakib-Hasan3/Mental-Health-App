// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  Stream<User?> get userStateChanges => _auth.authStateChanges();
  
  // Public getter for firestore document
  Future<DocumentSnapshot> getUserDocument(String uid) {
    return _firestore.collection('users').doc(uid).get();
  }
  
  // 📧 Email/Password Sign Up
  Future<UserModel?> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await userCredential.user?.updateDisplayName(name);
      
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        phone: phone,
        createdAt: DateTime.now(),
      );
      
      await _firestore.collection('users').doc(user.id).set(user.toMap());
      return user;
      
    } on FirebaseAuthException catch (e) {
      throw _getErrorMessage(e);
    }
  }
  
  // 📧 Email/Password Sign In
  Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      DocumentSnapshot doc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }
      return null;
      
    } on FirebaseAuthException catch (e) {
      throw _getErrorMessage(e);
    }
  }
  
  // 🌐 Google Sign In
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      DocumentSnapshot doc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      
      if (!doc.exists) {
        UserModel user = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? 'User',
          phone: '',
          createdAt: DateTime.now(),
          profileImage: userCredential.user!.photoURL,
        );
        await _firestore.collection('users').doc(user.id).set(user.toMap());
        return user;
      }
      
      return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      
    } on FirebaseAuthException catch (e) {
      throw _getErrorMessage(e);
    }
  }
  
  // 🔑 Forgot Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _getErrorMessage(e);
    }
  }
  
  // 🚪 Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
  
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found': return 'No user found with this email';
      case 'wrong-password': return 'Incorrect password';
      case 'email-already-in-use': return 'Email already in use';
      case 'weak-password': return 'Password is too weak';
      case 'network-request-failed': return 'Network error. Check your connection';
      default: return e.message ?? 'An error occurred';
    }
  }
}