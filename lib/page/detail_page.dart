import 'package:flutter/material.dart';
import 'package:flutter_sankalan/data/model/blog_model.dart';

class DetailPage extends StatelessWidget {
  ItemBlog item;

  DetailPage(this.item);

  double defaultTextSize = 18.0;

  double maxTextSize = 22.0;

  double currentTextSize = 18.0;

  final GlobalKey<ResizableTextState> key1 = new GlobalKey<ResizableTextState>();

  @override
  Widget build(BuildContext context) {
    assert(item != null);

    return new Scaffold(
      appBar: new AppBar(
        elevation: 2.0,
        title: new Text(
          item.title,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: new IconButton(icon: Icon(Icons.format_size), onPressed: onFontSizeButtonPress),
          )
        ],
      ),
      body: new Container(
        color: Colors.grey[100],
        child: new SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              ResizableText(key: key1, text: item.content),
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

  void onFontSizeButtonPress() {
    if (currentTextSize >= maxTextSize) {
      currentTextSize = defaultTextSize;
    } else
      currentTextSize = currentTextSize + 2.0;
    key1.currentState.onFontSizeChange(currentTextSize);
  }
}

class ResizableText extends StatefulWidget {
  final String text;

  ResizableText({Key key, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ResizableTextState();
  }
}

class ResizableTextState extends State<ResizableText> {
  double textSize = 18.0;
  @override
  Widget build(BuildContext context) {
    return new Text(
      widget.text,
      style: new TextStyle(fontSize: textSize, color: Colors.grey[900], height: 1.1),
    );
  }

  void onFontSizeChange(double currentTextSize) {
    setState(() {
      textSize = currentTextSize;
    });
  }
}
