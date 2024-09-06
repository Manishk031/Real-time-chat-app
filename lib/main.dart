import 'package:flutter/material.dart';
import 'package:real_time_chat/Pages/login_page.dart';
import 'package:real_time_chat/auth/login_or_register.dart';
import 'package:real_time_chat/themes/light.dart'; // Ensure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode, // Referencing lightMode from light.dart
      home:  const LoginOrRegister(),
    );
  }
}
