import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void showToast({String message}) {
    Fluttertoast.showToast(
        msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIos: 1, bgcolor: "#AA000000", textcolor: '#ffffff');
  }
}
