import 'dart:io';

import 'package:flutter/material.dart';

import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email, String password,
    String username, File image, 
    bool isLogin, BuildContext ctx,
  ) submitFn;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>(); // creating global key for form
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit () {
    final isValid = _formKey.currentState.validate(); // this will trigger all the validators
    FocusScope.of(context).unfocus(); // always helps to remove the keyboard because we take away focus from all the fields

    if(_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(), 
        _userPassword.trim(), 
        _userName.trim(),
        _userImageFile, 
        _isLogin, 
        context
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // means take space only as much needed
                children: <Widget>[
                  if(!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'), // we using key for unique identify by flutter when we switch to login and signup mode
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none, // not captilize any thing
                    enableSuggestions: false,
                    validator: (value) {
                      if(value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (val) => _userEmail = val,
                  ),
                  if(!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words, // not captilize any thing
                      enableSuggestions: false,
                      validator: (value) {
                        if(value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (val) => _userName = val,
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if(value.isEmpty || value.length < 7 ) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true, // this will hide the text
                    onSaved: (val) => _userPassword = val,
                  ),
                  SizedBox(height: 12),
                  if(widget.isLoading)
                    CircularProgressIndicator(),
                  if(!widget.isLoading)
                    RaisedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if(!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      }, 
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin ? 'Create new account' : 'I already have an account'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}