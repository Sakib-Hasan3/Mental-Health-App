// lib/utils/constants.dart
// কাজ: অ্যাপে ব্যবহৃত সব color, font, string ইত্যাদি এক জায়গায় রাখে

import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFF4A90E2);
  static const Color secondaryColor = Color(0xFF50E3C2);
  static const Color accentColor = Color(0xFFF5A623);
  
  // Background Colors
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Colors.white;
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFBDC3C7);
  
  // Status Colors
  static const Color successColor = Color(0xFF2ECC71);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color warningColor = Color(0xFFF39C12);
  
  // Mood Colors
  static const Color moodVeryLow = Color(0xFFE74C3C);
  static const Color moodLow = Color(0xFFF39C12);
  static const Color moodNormal = Color(0xFFF1C40F);
  static const Color moodGood = Color(0xFF2ECC71);
  static const Color moodExcellent = Color(0xFF27AE60);
}

class AppStrings {
  // App Name
  static const String appName = 'Mentora';
  static const String tagline = 'Your Companion in Mental Wellness';
  
  // Common
  static const String loading = 'Loading...';
  static const String error = 'Something went wrong';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  
  // Auth
  static const String login = 'Login';
  static const String signUp = 'Sign Up';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String forgotPassword = 'Forgot Password?';
  
  // Home
  static const String hello = 'Hello,';
  static const String welcomeBack = 'Welcome back';
  static const String quickActions = 'Quick Actions';
  static const String featuredMentors = 'Featured Mentors';
  static const String upcomingSessions = 'Upcoming Sessions';
  static const String moodTracker = 'How are you feeling today?';
}

class AppAssets {
  static const String logo = 'assets/images/logo.png';
  static const String placeholder = 'assets/images/placeholder.png';
  static const String animationLoading = 'assets/animations/loading.json';
  static const String animationWelcome = 'assets/animations/welcome.json';
}

/// 📏 অ্যাপ সাইজ এবং প্যাডিং
/// App sizing constants
class AppSizes {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
}

/// 📝 অ্যাপ টেক্সট স্টাইল
/// Application text styles
class AppTextStyles {
  static TextStyle get heading1 => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );
  
  static TextStyle get heading2 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );
  
  static TextStyle get heading3 => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );
  
  static TextStyle get bodyRegular => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );
  
  static TextStyle get caption => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );
}