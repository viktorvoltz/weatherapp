import 'package:flutter/material.dart';
import 'package:weatherapp/screens/homescreen.dart';
import 'package:weatherapp/screens/settingscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark
      ),
      initialRoute: '/',
      routes: {
        '/': (_)=> HomeScreen(),
        '/setting': (_) => SettingScreen()
      },
    );
  }
}


