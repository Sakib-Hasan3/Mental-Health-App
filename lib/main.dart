// lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'auth/login_screen.dart';
import 'home/home_screen.dart';

void main() async {
  // 🔴 WidgetsFlutterBinding.ensureInitialized() কেন?
  // Flutter এ main() ফাংশন asynchronous হওয়ার আগে
  // WidgetsFlutterBinding initialize করা প্রয়োজন
  WidgetsFlutterBinding.ensureInitialized();
  
  // 🔥 Firebase Initialize
  // Firebase কে start করতে হবে আমাদের অ্যাপের শুরুতে
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // অ্যাপ রান করুন
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔄 MultiProvider: একাধিক Provider একসাথে ব্যবহার করার জন্য
    return MultiProvider(
      providers: [
        // AuthProvider: ইউজারের লগইন স্টেট মেইনটেইন করে
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Mentora',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'GoogleFonts.poppins',
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            // 🧠 লজিক: ইউজার লগইন করলে Home Screen দেখাবে
            // না করলে Login Screen দেখাবে
            if (authProvider.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            
            if (authProvider.user != null) {
              return const HomeScreen();
            }
            
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}