/// 👨‍⚕️ মেন্টর মডেল
/// Mentor data model
class MentorModel {
  final String id;
  final String name;
  final String specialization;
  final String bio;
  final String? profileImage;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final String? experience;
  final List<String>? languages;

  MentorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.bio,
    this.profileImage,
    required this.rating,
    required this.reviewCount,
    required this.isAvailable,
    this.experience,
    this.languages,
  });

  // Convert from JSON
  factory MentorModel.fromJson(Map<String, dynamic> json) {
    return MentorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
      bio: json['bio'] ?? '',
      profileImage: json['profileImage'],
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      isAvailable: json['isAvailable'] ?? false,
      experience: json['experience'],
      languages: List<String>.from(json['languages'] ?? []),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'bio': bio,
      'profileImage': profileImage,
      'rating': rating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
      'experience': experience,
      'languages': languages,
    };
  }

  // Copy with method
  MentorModel copyWith({
    String? id,
    String? name,
    String? specialization,
    String? bio,
    String? profileImage,
    double? rating,
    int? reviewCount,
    bool? isAvailable,
    String? experience,
    List<String>? languages,
  }) {
    return MentorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isAvailable: isAvailable ?? this.isAvailable,
      experience: experience ?? this.experience,
      languages: languages ?? this.languages,
    );
  }
}
