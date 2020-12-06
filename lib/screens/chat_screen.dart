import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/new_message.dart';
import '../widgets/chat/messages.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    // this is we specially add for the ios pudh notification system
    // this code ask for the permissions
    final fbm = FirebaseMessaging();
    fbm.configure(onMessage: (msg) { // handle message while app is running
      print(msg);
      return; 
    }, onLaunch: (msg) { // handle message when the app is open
      print(msg);
      return;
    }, onResume: (msg){ // handle message  when app is not terminated but inside the RAM
      print(msg);
      return;
    });

    // to get the FCM token 
    //fbm.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: <Widget>[
          DropdownButton( // adding drop down button
            underline: Container(), // by default there is underline so we remove this by set container
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [ // dropdown items
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8), // for spacing
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ], 
            onChanged: (itemIdentifier) {
              if(itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut(); // so here we do the user sign out
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
