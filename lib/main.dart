import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat/services/auth/auth_gate.dart';
import 'package:real_time_chat/themes/light.dart';
import 'package:real_time_chat/themes/theme_provider.dart';

import 'firebase_options.dart'; // Ensure this path is correct

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child:  MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData, // Referencing lightMode from light.dart
      // home:  const AuthGate(),
      initialRoute: '/',
          routes: {
            '/': (context) => const AuthGate(),
          },
    );
  }
}
