// lib/models/user_model.dart
class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String role;
  final DateTime createdAt;
  final String? profileImage;
  final int moodScore;
  
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.role = 'user',
    required this.createdAt,
    this.profileImage,
    this.moodScore = 75,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      'createdAt': createdAt,
      'profileImage': profileImage,
      'moodScore': moodScore,
    };
  }
  
  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'user',
      createdAt: (map['createdAt'] as dynamic).toDate(),
      profileImage: map['profileImage'],
      moodScore: map['moodScore'] ?? 75,
    );
  }
}