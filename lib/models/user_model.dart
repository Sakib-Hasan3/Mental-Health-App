// lib/models/user_model.dart

class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String role; // 'user', 'mentor', 'admin'
  final DateTime createdAt;
  final String? profileImage;
  final bool isVerified;
  
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
    required this.createdAt,
    this.profileImage,
    this.isVerified = false,
  });
  
  // 🗺️ toMap(): Firestore এ সেভ করার জন্য Map এ convert করে
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      'createdAt': createdAt,
      'profileImage': profileImage,
      'isVerified': isVerified,
    };
  }
  
  // 🗺️ fromMap(): Firestore থেকে ডাটা পড়ে UserModel এ convert করে
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'user',
      createdAt: (map['createdAt'] as dynamic).toDate(),
      profileImage: map['profileImage'],
      isVerified: map['isVerified'] ?? false,
    );
  }
}