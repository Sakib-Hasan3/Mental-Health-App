// lib/screens/home/home_screen.dart
// কাজ: ইউজারের ড্যাশবোর্ড, যেখানে সব important তথ্য দেখাবে

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/user_provider.dart';
import '../../providers/mentor_provider.dart';
import '../../widgets/common/bottom_nav_bar.dart';
import '../../widgets/common/loading_widget.dart';
import '../../utils/constants.dart';
import 'home_components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 📍 Current page index (নিচের navigation bar এর জন্য)
  int _currentIndex = 0;
  
  // 📅 আজকের তারিখ
  String get _todayDate {
    final now = DateTime.now();
    return '${now.day} ${_getMonthName(now.month)}, ${now.year}';
  }
  
  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  @override
  void initState() {
    super.initState();
    // 🚀 Screen লোড হওয়ার সাথে সাথে ডাটা fetch করা শুরু করে
    _loadData();
  }
  
  Future<void> _loadData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final mentorProvider = Provider.of<MentorProvider>(context, listen: false);
    
    await userProvider.fetchUserData();
    await mentorProvider.fetchMentors();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final mentorProvider = Provider.of<MentorProvider>(context);
    
    if (userProvider.isLoading || mentorProvider.isLoading) {
      return const LoadingWidget();
    }
    
    final user = userProvider.user;
    final mentors = mentorProvider.mentors;
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========== 1. HEADER SECTION ==========
              _buildHeader(user?.name ?? 'User'),
              const SizedBox(height: 20),
              
              // ========== 2. WELCOME CARD ==========
              WelcomeCard(
                userName: user?.name ?? 'Guest',
                todayDate: _todayDate,
                moodScore: user?.moodScore ?? 75,
              ),
              const SizedBox(height: 24),
              
              // ========== 3. QUICK ACTIONS ==========
              const SectionTitle(title: 'Quick Actions'),
              const SizedBox(height: 12),
              const QuickActionsRow(),
              const SizedBox(height: 24),
              
              // ========== 4. TODAY'S MOOD TRACKER ==========
              const SectionTitle(title: "How are you feeling today?"),
              const SizedBox(height: 12),
              const MoodTrackerCard(),
              const SizedBox(height: 24),
              
              // ========== 5. FEATURED MENTORS ==========
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SectionTitle(title: 'Featured Mentors'),
                  TextButton(
                    onPressed: () => _navigateToMentors(),
                    child: const Text('See All →'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mentors.take(5).length,
                  itemBuilder: (context, index) {
                    final mentor = mentors[index];
                    return MentorCard(mentor: mentor);
                  },
                ),
              ),
              const SizedBox(height: 24),
              
              // ========== 6. UPCOMING APPOINTMENTS ==========
              const SectionTitle(title: 'Upcoming Sessions'),
              const SizedBox(height: 12),
              const UpcomingAppointmentsList(),
              const SizedBox(height: 20),
              
              // ========== 7. MENTAL HEALTH TIP ==========
              const DailyTipCard(),
              const SizedBox(height: 80), // Bottom nav bar এর জন্য space
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // TODO: Navigate to other screens
        },
      ),
    );
  }
  
  // 🏠 Header Section (Hello + Notification Icon)
  Widget _buildHeader(String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              userName.split(' ')[0], // শুধু first name দেখাবে
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _navigateToNotifications(),
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
  
  void _navigateToMentors() {
    // TODO: Navigate to mentors list screen
  }
  
  void _navigateToNotifications() {
    // TODO: Navigate to notifications screen
  }
}