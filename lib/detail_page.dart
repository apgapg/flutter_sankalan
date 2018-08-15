import 'package:flutter/material.dart';
import 'package:flutter_sankalan/data/model/blog_model.dart';

class DetailPage extends StatelessWidget {
  ItemBlog item;

  DetailPage(this.item);

  @override
  Widget build(BuildContext context) {
    assert(item != null);
    return new Scaffold(
      appBar: new AppBar(
        elevation: 2.0,
        title: new Text(
          item.title,
          style: new TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: new Container(
        color: Colors.grey[100],
        child: new SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              new Text(
                item.content,
                style: new TextStyle(fontSize: 16.0, color: Colors.grey[900], height: 1.1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: new Text(
                  "~ " + item.name,
                  style: new TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
