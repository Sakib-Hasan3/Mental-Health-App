// lib/main.dart
// কাজ: অ্যাপ শুরু হয় এখান থেকে। Firebase initialize করে এবং কোন স্ক্রিন দেখাবে সেটা decide করে।

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/mentor_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/login_screen.dart';
import 'utils/theme.dart';
import 'widgets/common/loading_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 🔐 AuthProvider: লগইন/লগআউট manage করে
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        
        // 👤 UserProvider: ইউজারের ডাটা manage করে
        ChangeNotifierProvider(create: (_) => UserProvider()),
        
        // 👨‍🏫 MentorProvider: মেন্টরদের লিস্ট manage করে
        ChangeNotifierProvider(create: (_) => MentorProvider()),
      ],
      child: MaterialApp(
        title: 'Mentora',
        theme: AppTheme.lightTheme, // 🎨 থিম সেটিংস
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            // ইউজার লগইন থাকলে home screen, না থাকলে login screen
            if (authProvider.isLoading) {
              return const LoadingWidget();
            }
            return authProvider.user != null 
                ? const HomeScreen() 
                : const LoginScreen();
          },
        ),
      ),
    );
  }
}