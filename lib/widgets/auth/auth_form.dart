import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm({Key key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min, // means take space only as much needed
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true, // this will hide the text
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Login'),
                  ),
                  FlatButton(
                    onPressed: () {}, 
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Create new account'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}