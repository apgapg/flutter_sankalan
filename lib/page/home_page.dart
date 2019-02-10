import 'package:flutter/material.dart';
import 'package:flutter_sankalan/bloc/home_bloc.dart';
import 'package:flutter_sankalan/data/model/blog_model.dart';
import 'package:flutter_sankalan/page/detail_page.dart';
import 'package:flutter_sankalan/page/upload_story_page.dart';
import 'package:flutter_sankalan/utils/dialog_utils.dart';
import 'package:flutter_sankalan/utils/prefs_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 2.0,
        title: Row(
          children: <Widget>[
            Container(
              height: 36.0,
              width: 36.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text(
                "Sankalan",
                style: new TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: new IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: onInfoPress,
            ),
          ),
        ],
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
        child: Stack(
          children: <Widget>[
            new ListView.builder(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              itemBuilder: (context, index) {
                return getBlogCard(model.list[index]);
              },
              itemCount: model.list.length,
            ),
            /*SingleChildScrollView(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
              scrollDirection: Axis.horizontal,
              child: Container(
                child: new Row(
                  children: <Widget>[
                    GroupTextWidget(text: "Popular"),
                    GroupTextWidget(text: "हिन्दी"),
                    GroupTextWidget(text: "English"),
                    GroupTextWidget(text: "Hinglish"),
                  ],
                ),
              ),
            ),*/
          ],
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
        decoration: new BoxDecoration(color: Colors.white, shape: BoxShape.rectangle, boxShadow: <BoxShadow>[new BoxShadow(color: Colors.grey, blurRadius: 1.5)]),
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

  void onInfoPress() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: new Text("About the Developer:"),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 100.0,
                    width: 96.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage('assets/images/ayush.jpeg'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: new Text(
                      "Made with ❤️ by Ayush P Gupta",
                      style: new TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          height: 28.0,
                          width: 28.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage('assets/images/github.png'),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          await launch("https://github.com/apgapg");
                        },
                      ),
                      SizedBox(
                        width: 24.0,
                      ),
                      GestureDetector(
                        child: Container(
                          height: 30.0,
                          width: 28.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('assets/images/medium.png'),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          await launch("https://medium.com/@ayushpguptaapg/");
                        },
                      ),
                      SizedBox(
                        width: 24.0,
                      ),
                      GestureDetector(
                        child: Container(
                          height: 24.0,
                          width: 28.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage('assets/images/linkedin.png'),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          await launch("https://www.linkedin.com/in/ayush-p-gupta-72026a119/");
                        },
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text("CLOSE")),
              ],
            ));
  }
}

class GroupTextWidget extends StatelessWidget {
  final String text;

  GroupTextWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 100.0,
      child: new Card(
        color: Colors.white,
        elevation: 2.0,
        margin: const EdgeInsets.all(4.0),
        child: new Center(
          child: new Text(
            text,
            style: new TextStyle(color: Colors.teal, fontSize: 16.0, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
