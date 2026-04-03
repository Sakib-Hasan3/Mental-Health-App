// lib/screens/home/home_components.dart
// কাজ: হোম পেজের reusable widgets (যেগুলো বারবার ব্যবহার করা যায়)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/mentor_model.dart';
import '../../utils/constants.dart';

// ============================================
// 1. WELCOME CARD - স্বাগতম কার্ড
// ============================================
class WelcomeCard extends StatelessWidget {
  final String userName;
  final String todayDate;
  final int moodScore;
  
  const WelcomeCard({
    super.key,
    required this.userName,
    required this.todayDate,
    required this.moodScore,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, $userName!',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            todayDate,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wellness Score',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    '$moodScore%',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Circular Progress Indicator
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: moodScore / 100,
                  strokeWidth: 6,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================
// 2. SECTION TITLE - সেকশনের টাইটেল
// ============================================
class SectionTitle extends StatelessWidget {
  final String title;
  
  const SectionTitle({
    super.key,
    required this.title,
  });
  
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}

// ============================================
// 3. QUICK ACTIONS - দ্রুত কর্ম (বাটন)
// ============================================
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});
  
  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.chat_bubble_outline, 'label': 'AI Chat', 'color': AppColors.primaryColor},
      {'icon': Icons.psychology_outlined, 'label': 'Mentor', 'color': AppColors.secondaryColor},
      {'icon': Icons.health_and_safety_outlined, 'label': 'Doctor', 'color': Colors.green},
      {'icon': Icons.self_improvement_outlined, 'label': 'Meditate', 'color': Colors.purple},
    ];
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actions.map((action) {
        return _QuickActionButton(
          icon: action['icon'] as IconData,
          label: action['label'] as String,
          color: action['color'] as Color,
          onTap: () {
            // TODO: Handle navigation
          },
        );
      }).toList(),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================
// 4. MOOD TRACKER CARD - মেজাজ ট্র্যাকার
// ============================================
class MoodTrackerCard extends StatefulWidget {
  const MoodTrackerCard({super.key});
  
  @override
  State<MoodTrackerCard> createState() => _MoodTrackerCardState();
}

class _MoodTrackerCardState extends State<MoodTrackerCard> {
  int _selectedMood = 3; // 1-5 scale, 3 = normal
  
  final List<Map<String, dynamic>> _moods = [
    {'emoji': '😔', 'label': 'Very Low', 'color': Colors.red, 'value': 1},
    {'emoji': '😕', 'label': 'Low', 'color': Colors.orange, 'value': 2},
    {'emoji': '😐', 'label': 'Normal', 'color': Colors.yellow, 'value': 3},
    {'emoji': '🙂', 'label': 'Good', 'color': Colors.lightGreen, 'value': 4},
    {'emoji': '😊', 'label': 'Excellent', 'color': Colors.green, 'value': 5},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _moods.map((mood) {
              final isSelected = _selectedMood == mood['value'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMood = mood['value'];
                  });
                  _saveMood(mood['value']);
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? (mood['color'] as Color).withOpacity(0.2)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: mood['color'], width: 2)
                            : null,
                      ),
                      child: Text(
                        mood['emoji'],
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mood['label'],
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: isSelected 
                            ? mood['color']
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _saveMood(_selectedMood),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Log My Mood'),
            ),
          ),
        ],
      ),
    );
  }
  
  void _saveMood(int moodValue) {
    // TODO: Save mood to Firebase
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mood logged: ${_moods[moodValue - 1]['label']}')),
    );
  }
}

// ============================================
// 5. MENTOR CARD - মেন্টরের কার্ড
// ============================================
class MentorCard extends StatelessWidget {
  final MentorModel mentor;
  
  const MentorCard({
    super.key,
    required this.mentor,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          CircleAvatar(
            radius: 30,
            backgroundImage: mentor.profileImage != null
                ? NetworkImage(mentor.profileImage!)
                : null,
            child: mentor.profileImage == null
                ? Text(mentor.name[0], style: const TextStyle(fontSize: 24))
                : null,
          ),
          const SizedBox(height: 12),
          Text(
            mentor.name,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            mentor.specialization,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                mentor.rating.toString(),
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              const SizedBox(width: 8),
              Text(
                '(${mentor.reviewCount} reviews)',
                style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textSecondary),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _bookMentor(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text('Book', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
  
  void _bookMentor(BuildContext context) {
    // TODO: Navigate to booking screen
  }
}

// ============================================
// 6. UPCOMING APPOINTMENTS LIST
// ============================================
class UpcomingAppointmentsList extends StatelessWidget {
  const UpcomingAppointmentsList({super.key});
  
  @override
  Widget build(BuildContext context) {
    // TODO: Fetch from Firestore
    final appointments = [
      {'mentor': 'Dr. Sarah Rahman', 'time': 'Today, 4:00 PM', 'type': 'Video Call'},
      {'mentor': 'Mr. Hasan Ahmed', 'time': 'Tomorrow, 10:30 AM', 'type': 'Chat Session'},
    ];
    
    if (appointments.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(Icons.calendar_today, size: 48, color: AppColors.textSecondary),
            const SizedBox(height: 12),
            Text(
              'No upcoming sessions',
              style: GoogleFonts.poppins(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('Book a Mentor'),
            ),
          ],
        ),
      );
    }
    
    return Column(
      children: appointments.map((appointment) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.video_call, color: AppColors.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment['mentor']!,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      appointment['time']!,
                      style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary),
                    ),
                    Text(
                      appointment['type']!,
                      style: GoogleFonts.poppins(fontSize: 10, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Confirmed',
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ============================================
// 7. DAILY TIP CARD
// ============================================
class DailyTipCard extends StatelessWidget {
  const DailyTipCard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondaryColor, AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.lightbulb, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Mental Health Tip',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Take 5 deep breaths. Inhale for 4 seconds, hold for 4, exhale for 4.',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
