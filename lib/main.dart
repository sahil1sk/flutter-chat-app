import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './screens/chat_screen.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreen(),
    );
  }
}
