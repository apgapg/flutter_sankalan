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

  Future<http.Response> makeViewsUpdateRequest(int id) async {
    Map<String, String> map = new Map();
    map.putIfAbsent("id", () => id.toString());
    var response = await http.post(baseUrl + 'updateviews.php', body: map);
    return response;
  }

  Future uploadStory(String textTitle, String textWriterName, String textStory) async {
    Map<String, String> map = new Map();
    //TODO:change this
    map.putIfAbsent("uid", () => "1");
    map.putIfAbsent("title", () => textTitle.toString());
    map.putIfAbsent("writername", () => textWriterName.toString());
    map.putIfAbsent("story", () => textStory.toString());

    var response = await http.post(baseUrl + 'uploadstory.php', body: map);
    return response;
  }
}
