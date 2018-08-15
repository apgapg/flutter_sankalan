import 'dart:async';

import 'package:http/http.dart' as http;

ApiHelper apiHelper = new ApiHelper();

class ApiHelper {
  static final ApiHelper _instance = new ApiHelper._internal();

  static String baseUrl = "https://sankalan.000webhostapp.com/";

  factory ApiHelper() {
    return _instance;
  }

  ApiHelper._internal();

  Future<http.Response> fetchData() async {
    var response = await http.get(baseUrl + 'test.php');
    return response;
  }
}
