import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart'; // for using PlatformException handle
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';


class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance; // getting auth instance
  var _isLoading = false;

  void _submitAuthForm(
    String email, String password, 
    String username, File image, 
    bool isLogin, BuildContext ctx,
  ) async {
    var authResult;

    try{
      setState(() {
        _isLoading = true;
      });
      if(isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email, 
          password: password
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );

        final ref = FirebaseStorage.instance
        .ref()
        .child('user_image') // adding user_image folder at firebase storage
        .child(authResult.user.uid + '.jpg'); // in folder we adding the image with unique name

        await ref.putFile(image); // so here we putting the file with name wich we define means unique name

        final url = await ref.getDownloadURL();

        // so when the new user signUp by using its id we set extra data on its document
        await FirebaseFirestore
        .instance.collection('users') // getting user collection
        .doc(authResult.user.uid) // getting document with userid
        .set({  // setting the data
          'username': username,
          'email': email,
          'image_url': url,
        });
      }

    } on PlatformException catch(err) { // when platformException arises
      var message = 'An error occured, please check your credentials!';

      if(err.message != null){
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}