import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sankalan/page/home_page.dart';
import 'package:flutter_sankalan/utils/prefs_helper.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  prefsHelper.initialize();
  return runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new HomePage(),
    );
  }
}
