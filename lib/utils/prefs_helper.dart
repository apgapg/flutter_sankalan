import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

SharedPrefsHelper prefsHelper = new SharedPrefsHelper();

class SharedPrefsHelper {
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();

  SharedPreferences _prefs;

  String USER_LOGGED = "userlogged";
  String USER_TOKEN = "token";
  String USER_EMAIL = "email";

  factory SharedPrefsHelper() {
    return _instance;
  }

  SharedPrefsHelper._internal();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    return 0;
  }

  set userLogged(value) => _prefs.setBool(USER_LOGGED, value);

  get userLogged => _prefs.getBool(USER_LOGGED) ?? false;

  set token(value) => _prefs.setString(USER_TOKEN, value);

  get token => _prefs.getString(USER_TOKEN) ?? false;

  set email(value) => _prefs.setString(USER_EMAIL, value);

  get email => _prefs.getString(USER_EMAIL) ?? false;
}
