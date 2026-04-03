import 'package:flutter/material.dart';

/// 👤 ইউজার ডেটা মডেল
class UserData {
  final String? id;
  final String? name;
  final String? email;
  final String? profileImage;
  final int moodScore;

  UserData({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.moodScore = 75,
  });
}

/// 👤 ইউজার প্রোভাইডার
/// User data provider using ChangeNotifier
class UserProvider extends ChangeNotifier {
  UserData? _user;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  UserData? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// প্রোফাইল ডাটা ফেচ করুন
  Future<void> fetchUserData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Implement Firebase/API call to fetch user data
      // For now, using mock data
      await Future.delayed(const Duration(seconds: 1));
      
      _user = UserData(
        id: 'user_123',
        name: 'John Doe',
        email: 'john@example.com',
        profileImage: null,
        moodScore: 75,
      );
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// প্রোফাইল আপডেট করুন
  Future<void> updateProfile({
    String? name,
    String? email,
    String? profileImage,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Implement Firebase/API call to update user profile
      _user = UserData(
        id: _user?.id,
        name: name ?? _user?.name,
        email: email ?? _user?.email,
        profileImage: profileImage ?? _user?.profileImage,
        moodScore: _user?.moodScore ?? 75,
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// লগআউট করুন
  Future<void> logout() async {
    _user = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// প্রোভাইডার রিসেট করুন
  void reset() {
    _user = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}
