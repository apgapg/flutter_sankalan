import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sankalan/page/upload_story_page.dart';
import 'package:flutter_sankalan/utils/prefs_helper.dart';
import 'package:flutter_sankalan/utils/toast_utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return new LoginPageState();
  }
}

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class LoginPageState extends State<LoginPage> {
  GoogleSignInAccount _currentUser;
  BuildContext context;

  @override
  void initState() {
    super.initState();
    initGoogleSignIn();
  }

  Future initGoogleSignIn() async {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      _currentUser = account;
      print(_currentUser.displayName);
      GoogleSignInAuthentication authentication = await _currentUser.authentication;
      //homeBloc.validateAuth(authentication.idToken);
      Navigator.pop(context);
      ToastUtils.showToast(message: "Login Successful!");
      prefsHelper.userLogged = true;
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new UploadStoryPage()));
    });
  }

  Future<Null> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new AlertDialog(
      title: new Text("Login Required"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text("Please login to upload your story."),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new OutlineButton(
              onPressed: () {
                _handleSignIn();
              },
              child: new Text("Google SignIn"),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('LATER'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
