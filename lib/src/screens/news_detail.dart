import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;


  //This constructor assigns the value passed into it into the itemId variable

  NewsDetail({this.itemId});

  Widget build(context,) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Text("$itemId"),
    );
  }
}
