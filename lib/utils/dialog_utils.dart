import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sankalan/page/login_page.dart';

class DialogUtils {
  static void showLoginReqDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => LoginPage());
  }
}
