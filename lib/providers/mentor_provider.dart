import 'package:flutter/material.dart';
import '../models/mentor_model.dart';

/// 👨‍🏫 মেন্টর প্রোভাইডার
/// Mentor data provider using ChangeNotifier
class MentorProvider extends ChangeNotifier {
  List<MentorModel> _mentors = [];
  MentorModel? _selectedMentor;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<MentorModel> get mentors => _mentors;
  MentorModel? get selectedMentor => _selectedMentor;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// মেন্টরদের তালিকা ফেচ করুন
  Future<void> fetchMentors() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Implement Firebase/API call to fetch mentors
      // For now, using mock data
      await Future.delayed(const Duration(seconds: 1));
      
      _mentors = [
        MentorModel(
          id: 'mentor_1',
          name: 'Dr. Sarah Jane',
          specialization: 'Clinical Psychologist',
          bio: 'Experienced psychologist with 10+ years in mental health',
          profileImage: null,
          rating: 4.8,
          reviewCount: 127,
          isAvailable: true,
          experience: '10+ years',
          languages: ['English', 'Bengali'],
        ),
        MentorModel(
          id: 'mentor_2',
          name: 'Dr. Ahmed Khan',
          specialization: 'Therapist',
          bio: 'Specialized in anxiety and depression treatment',
          profileImage: null,
          rating: 4.6,
          reviewCount: 95,
          isAvailable: true,
          experience: '8+ years',
          languages: ['English', 'Bengali', 'Urdu'],
        ),
      ];
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// নির্দিষ্ট মেন্টর নির্বাচন করুন
  void selectMentor(MentorModel mentor) {
    _selectedMentor = mentor;
    notifyListeners();
  }

  /// মেন্টর অনুসন্ধান করুন
  List<MentorModel> searchMentors(String query) {
    return _mentors
        .where((mentor) =>
            mentor.name.toLowerCase().contains(query.toLowerCase()) ||
            mentor.specialization.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// উপলব্ধ মেন্টরদের ফিল্টার করুন
  List<MentorModel> getAvailableMentors() {
    return _mentors.where((mentor) => mentor.isAvailable).toList();
  }

  /// সর্বোচ্চ রেটিং সহ মেন্টররা
  List<MentorModel> getTopRatedMentors({int limit = 5}) {
    final sorted = List<MentorModel>.from(_mentors);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(limit).toList();
  }

  /// প্রোভাইডার রিসেট করুন
  void reset() {
    _mentors = [];
    _selectedMentor = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}
