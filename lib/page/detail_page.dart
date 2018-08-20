import 'package:flutter/material.dart';
import 'package:flutter_sankalan/data/model/blog_model.dart';

class DetailPage extends StatefulWidget {
  ItemBlog item;

  DetailPage(this.item);

  @override
  DetailPageState createState() {
    return new DetailPageState();
  }
}

class DetailPageState extends State<DetailPage> {
  double defaultTextSize = 18.0;

  double maxTextSize = 22.0;

  double currentTextSize = 18.0;

  Color textColorDay = Colors.black87;
  Color backgroundColorDay = Colors.grey[100];
  Color textColorNight = Colors.white70;
  Color backgroundColorNight = Colors.grey[900];
  bool nightMode = false;

  @override
  Widget build(BuildContext context) {
    assert(widget.item != null);

    return new Scaffold(
      backgroundColor: nightMode ? backgroundColorNight : backgroundColorDay,
      appBar: new AppBar(
        elevation: 2.0,
        title: new Text(
          widget.item.title,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: new IconButton(icon: Icon(Icons.brightness_medium), onPressed: onNightModePress),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: new IconButton(icon: Icon(Icons.format_size), onPressed: onFontSizeButtonPress),
          ),
        ],
      ),
      body: new Container(
        child: new SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              new Text(
                widget.item.content,
                style: new TextStyle(fontSize: currentTextSize, color: nightMode ? textColorNight : textColorDay, height: 1.1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: new Text(
                  "~ " + widget.item.name,
                  style: new TextStyle(fontSize: 16.0, color: nightMode ? textColorNight : textColorDay, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onFontSizeButtonPress() {
    setState(() {
      if (currentTextSize >= maxTextSize) {
        currentTextSize = defaultTextSize;
      } else
        currentTextSize = currentTextSize + 2.0;
    });
  }

  void onNightModePress() {
    setState(() {
      nightMode = !nightMode;
    });
  }
}
