import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email, String password,
    String username, bool isLogin,  
  ) submitFn;

  AuthForm(this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>(); // creating global key for form
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit () {
    final isValid = _formKey.currentState.validate(); // this will trigger all the validators
    FocusScope.of(context).unfocus(); // always helps to remove the keyboard because we take away focus from all the fields

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail, _userPassword, _userName, _isLogin);
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
                  TextFormField(
                    key: ValueKey('email'), // we using key for unique identify by flutter when we switch to login and signup mode
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
                  RaisedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    }, 
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin ? 'Create new account' : 'I already have an account'),
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