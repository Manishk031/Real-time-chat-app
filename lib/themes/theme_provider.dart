

import 'package:flutter/material.dart';

import 'package:real_time_chat/themes/light.dart';

import 'dark.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if (_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}