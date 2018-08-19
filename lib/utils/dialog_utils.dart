import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sankalan/page/login_page.dart';

class DialogUtils {
  static void showLoginReqDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => LoginPage());
  }

  static void showProgressBar(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new Dialog(
            child: new Container(
              height: 80.0,
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new CircularProgressIndicator(),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: new Text(
                      text,
                      style: new TextStyle(color: Colors.grey[700], fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
