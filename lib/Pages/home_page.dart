import 'package:flutter/material.dart';
import 'package:real_time_chat/auth/auth_services.dart';

class HomePage extends StatelessWidget{
  const HomePage ({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("Home"),


    ),
      drawer: Drawer(),
    );
  }
}