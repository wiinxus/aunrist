import 'dart:convert';

import 'package:aunrist/models/pageholder_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
// Explicit
// List<String> test = ['AA','BB','CC'];
  List<PageHolderModel> pageHolderModels = [];

// Method

  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    String urlAPI = 'http://jsonplaceholder.typicode.com/posts';
    Response response = await get(urlAPI);
    var result = json.decode(response.body);
    print('result=$result');

    for (var map in result) {
      PageHolderModel holderModel = PageHolderModel.fromJson(map);
      String title = holderModel.title;
      print('title = $title');

      setState(() {
        pageHolderModels.add(holderModel);
      });
    }
  }

  Widget showTitle(int index) {
    return Text(pageHolderModels[index].title);
  }

  Widget showListView(int index) {
    return Container(padding: EdgeInsets.all(10.0),
      decoration: index % 2 == 0
          ? BoxDecoration(color: Colors.blue)
          : BoxDecoration(color: Colors.blue[100]),
      child: Column(
        children: <Widget>[
          showTitle(index),
          // Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pageHolderModels.length,
      itemBuilder: (BuildContext context, int index) {
        return showListView(index);
      },
    );
  }
}
