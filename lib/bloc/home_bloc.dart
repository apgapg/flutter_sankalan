import 'dart:async';
import 'dart:convert';

import 'package:flutter_sankalan/data/api_helper.dart';
import 'package:flutter_sankalan/data/model/blog_model.dart';
import 'package:flutter_sankalan/utils/network_utils.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

HomeBloc homeBloc = new HomeBloc();

class HomeBloc {
  static HomeBloc _instance = new HomeBloc._internal();
  final BehaviorSubject<BlogModel> dataController = new BehaviorSubject();

  factory HomeBloc() {
    return _instance;
  }

  HomeBloc._internal() {
    initData();
    initAnalytics();
  }

  Future initData() async {
    try {
      http.Response response = await apiHelper.fetchData();
      if (NetworkUtils.isReqSuccess(tag: "BlogData", response: response)) {
        BlogModel blogModel = BlogModel.fromJson(json.decode(response.body));
        dataController.sink.add(blogModel);
      } else {
        dataController.addError("Something went wrong. ErrorCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      dataController.addError("Internet not available");
    }
  }

  Future makeViewsUpdateRequest(int id) async {
    await apiHelper.makeViewsUpdateRequest(id);
  }

  void validateAuth(String idToken) {
    assert(idToken != null);
  }

  Future initAnalytics() async {
    await apiHelper.makeAnalytics();
  }
}
