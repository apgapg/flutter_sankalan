import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sankalan/data/api_helper.dart';
import 'package:flutter_sankalan/page/upload_story_page.dart';
import 'package:flutter_sankalan/utils/dialog_utils.dart';
import 'package:flutter_sankalan/utils/network_utils.dart';
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

      makeAuthReq(authentication.idToken);
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
            child: new RaisedButton(
              textColor: Colors.white,
              color: Colors.teal,
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

  Future makeAuthReq(String idToken) async {
    assert(idToken != null);
    DialogUtils.showProgressBar(context, "Please Wait!");
    try {
      var response = await apiHelper.makeLoginReq(idToken);
      if (NetworkUtils.isReqSuccess(tag: "login", response: response)) {
        Map map = json.decode(response.body);
        prefsHelper.token = map['token'];
        prefsHelper.email = map['email'];

        Navigator.pop(context);
        Navigator.pop(context);
        ToastUtils.showToast(message: "Login Successful!");
        prefsHelper.userLogged = true;

        Navigator.push(context, new MaterialPageRoute(builder: (context) => new UploadStoryPage()));

        //Navigator.pop(context);
      } else {
        Navigator.pop(context);

        _googleSignIn.signOut();
        ToastUtils.showToast(message: "Something went wrong. Please try again.");
      }
    } catch (e) {
      Navigator.pop(context);

      print(e);
      _googleSignIn.signOut();

      ToastUtils.showToast(message: "Something went wrong. Please try again.");
    }
  }
}
