import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sankalan/bloc/home_bloc.dart';
import 'package:flutter_sankalan/data/api_helper.dart';
import 'package:flutter_sankalan/utils/dialog_utils.dart';
import 'package:flutter_sankalan/utils/network_utils.dart';
import 'package:flutter_sankalan/utils/toast_utils.dart';

class UploadStoryPage extends StatefulWidget {
  @override
  UploadStoryPageState createState() {
    return new UploadStoryPageState();
  }
}

class UploadStoryPageState extends State<UploadStoryPage> {
  final TextEditingController textTitle = new TextEditingController();

  final TextEditingController textWriterName = new TextEditingController();

  final TextEditingController textStory = new TextEditingController();

  BuildContext context;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        elevation: 2.0,
        title: new Text("Upload Story"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: new IconButton(
              icon: Icon(Icons.done),
              onPressed: onDonePress,
            ),
          ),
        ],
      ),
      body: new Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Container(
                child: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Story Title",
                    contentPadding: const EdgeInsets.all(16.0),
                    border: InputBorder.none,
                  ),
                  controller: textTitle,
                  style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black87),
                  maxLines: 1,
                ),
                color: Colors.white,
              ),
              new Divider(
                height: 1.0,
              ),
              Container(
                color: Colors.white,
                child: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Writer Name",
                    contentPadding: const EdgeInsets.all(16.0),
                    border: InputBorder.none,
                  ),
                  controller: textWriterName,
                  style: new TextStyle(fontSize: 17.0, color: Colors.black54, fontWeight: FontWeight.w700),
                ),
              ),
              new Divider(
                height: 1.0,
              ),
              Container(
                color: Colors.white,
                child: ConstrainedBox(
                  child: new TextField(
                    decoration: new InputDecoration(
                      hintText: "Paste Your Story here",
                      contentPadding: const EdgeInsets.all(16.0),
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    controller: textStory,
                    style: new TextStyle(height: 1.1, color: Colors.black87, fontSize: 16.0),
                  ),
                  constraints: BoxConstraints(minHeight: 100.0),
                ),
              ),
              new Divider(
                height: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: Container(
                  height: 70.0,
                  width: 70.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/happy.png'),

                        // ...
                      ),
                      // ...
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
                child: new Text(
                  "Please refrain yourself from posting any:\n\n- Illegal content and conduct\n- Intellectual property infringement\n- Technologically harmful content\n- Impersonation\n- Directly threatening material\n- Posting private information\n- Advertising & Spam ",
                  style: new TextStyle(color: Colors.grey[500]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onDonePress() {
    if (textTitle.text != null &&
        textWriterName.text != null &&
        textStory.text != null &&
        textTitle.text.trim().isNotEmpty &&
        textWriterName.text.trim().isNotEmpty &&
        textStory.text.trim().isNotEmpty) {
      uploadStory(textTitle.text.trim(), textWriterName.text.trim(), textStory.text.trim());
    } else {
      ToastUtils.showToast(message: "Please fill all details");
    }
  }

  Future uploadStory(String textTitle, String textWriterName, String textStory) async {
    DialogUtils.showProgressBar(context, "Uploading!");

    try {
      var response = await apiHelper.uploadStory(textTitle, textWriterName, textStory);
      if (NetworkUtils.isReqSuccess(tag: "uploadStory", response: response)) {
        ToastUtils.showToast(message: "Story uploaded successfully");
        homeBloc.initData();
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        Navigator.popUntil(context, (route) => route.isFirst);

        ToastUtils.showToast(message: "Something went wrong. Please try again.");
      }
    } catch (e) {
      print(e);
      Navigator.popUntil(context, (route) => route.isFirst);

      ToastUtils.showToast(message: "Something went wrong. Please try again.");
    }
  }
}
