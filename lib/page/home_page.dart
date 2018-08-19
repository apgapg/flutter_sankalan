import 'package:flutter/material.dart';
import 'package:flutter_sankalan/bloc/home_bloc.dart';
import 'package:flutter_sankalan/data/model/blog_model.dart';
import 'package:flutter_sankalan/page/detail_page.dart';
import 'package:flutter_sankalan/page/upload_story_page.dart';
import 'package:flutter_sankalan/utils/dialog_utils.dart';
import 'package:flutter_sankalan/utils/prefs_helper.dart';

class HomePage extends StatelessWidget {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: new Text(
          "Sankalan",
          style: new TextStyle(fontWeight: FontWeight.w500),
        ),
        elevation: 2.0,
      ),
      body: body(),
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget body() {
    return new StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<BlogModel> snapshot) {
        if (snapshot.hasData) {
          return blogBody(snapshot.data);
        } else if (snapshot.hasError) {
          return new Container(
            child: new Center(
              child: new Text(snapshot.error.toString()),
            ),
          );
        } else {
          return Container(
            color: Colors.grey[200],
            child: new Center(
              child: new CircularProgressIndicator(),
            ),
          );
        }
      },
      stream: homeBloc.dataController.stream,
    );
  }

  Widget blogBody(BlogModel model) {
    return new Container(
        color: Colors.grey[200],
        child: new ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          itemBuilder: (context, index) {
            return getBlogCard(model.list[index]);
          },
          itemCount: model.list.length,
        ));
  }

  Widget getBlogCard(ItemBlog item) {
    return GestureDetector(
      onTap: () {
        openDetailPage(item);
      },
      child: new Card(
        margin: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        elevation: 2.0,
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 4.0),
              child: new Text(
                item.title,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 18.0),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 2.0, bottom: 4.0),
              child: new Text(
                item.content,
                style: new TextStyle(color: Colors.grey[800], fontSize: 16.0),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            new Container(
              height: 28.0,
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 6.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: new Text(
                      "~ " + item.name,
                      style: new TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: new Icon(
                      Icons.remove_red_eye,
                      size: 16.0,
                      color: Colors.grey[500],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: new Text(
                      item.views.toString(),
                      style: new TextStyle(color: Colors.grey[700], fontSize: 13.0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomBar() {
    return GestureDetector(
      onTap: () {
        //ToastUtils.showToast(message: "Hang on. Feature coming soon!");
        if (prefsHelper.userLogged)
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new UploadStoryPage()));
        else
          DialogUtils.showLoginReqDialog(context);
      },
      child: new Container(
        decoration: new BoxDecoration(
            color: Colors.white, shape: BoxShape.rectangle, boxShadow: <BoxShadow>[new BoxShadow(color: Colors.grey, blurRadius: 1.5)]),
        height: 44.0,
        child: new Center(
          child: new Text(
            "UPLOAD YOUR STORY",
            style: new TextStyle(fontWeight: FontWeight.w700, color: Colors.teal, fontSize: 15.0),
          ),
        ),
      ),
    );
  }

  void openDetailPage(ItemBlog item) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new DetailPage(item)));
    homeBloc.makeViewsUpdateRequest(item.id);
  }
}
