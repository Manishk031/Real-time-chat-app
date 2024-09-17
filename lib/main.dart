import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:real_time_chat/auth/auth_gate.dart';
import 'package:real_time_chat/auth/login_or_register.dart';
import 'package:real_time_chat/services/auth/auth_gate.dart';
import 'package:real_time_chat/themes/light.dart';

import 'firebase_options.dart'; // Ensure this path is correct

void main() async{
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode, // Referencing lightMode from light.dart
      home:  const AuthGate(),
    );
  }
}
