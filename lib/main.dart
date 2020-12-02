import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';


void main() {
  runApp(MyApp());
  Firebase.initializeApp(); // Initializing the firebase app
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark, // the text on it should be bright
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),//ChatScreen(),
    );
  }
}
