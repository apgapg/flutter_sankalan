import 'dart:async';
import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter_sankalan/utils/prefs_helper.dart';
import 'package:http/http.dart' as http;

ApiHelper apiHelper = new ApiHelper();

class ApiHelper {
  static final ApiHelper _instance = new ApiHelper._internal();

  static String baseUrl = "https://sankalan.000webhostapp.com/";

  factory ApiHelper() {
    return _instance;
  }

  ApiHelper._internal() {
    initDeviceData();
  }

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
    map.putIfAbsent("uid", () => prefsHelper.email);
    map.putIfAbsent("title", () => textTitle.toString());
    map.putIfAbsent("writername", () => textWriterName.toString());
    map.putIfAbsent("story", () => textStory.toString());
    map.putIfAbsent("token", () => prefsHelper.token);
    if (deviceData != null) map.putIfAbsent("device", () => json.encode(deviceData));

    var response = await http.post(baseUrl + 'uploadstory.php', body: map);
    return response;
  }

  Future makeLoginReq(String idToken) async {
    assert(idToken != null);
    Map<String, String> map = new Map();
    map.putIfAbsent("idToken", () => idToken);
    if (deviceData != null) map.putIfAbsent("device", () => json.encode(deviceData));

    var response = await http.post(baseUrl + 'login.php', body: map);
    return response;
  }

  Future makeAnalytics() async {
    Map<String, String> map = new Map();
    map.putIfAbsent("email", () => prefsHelper.email ?? "default");
    if (deviceData != null) map.putIfAbsent("device", () => json.encode(deviceData));
    var response = await http.post(baseUrl + 'analytics.php', body: map);
    return response;
  }

  static final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};

  Future initDeviceData() async {
    deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'hardware': build.hardware,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
    };
  }
}
