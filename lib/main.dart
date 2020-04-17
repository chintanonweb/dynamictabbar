import 'dart:async';

import 'package:mysql1/mysql1.dart';
//import 'package:chintzz/bottom_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<String> categories = [
    "art",
    "beach",
    "catch",
    "dpg",
    "enjoy",
    "fog",
    "game",
    "house"
  ];
  final List<String> _category = [];
  final List<String> _categoryImage = [];
  final List<String> _categoryId = [];
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext ctxt) {
    return SafeArea(
      top: true,
      bottom: true,
      child: new MaterialApp(
         debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: _category.length,
            child: new Scaffold(
                appBar: new AppBar(
                  flexibleSpace: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      new TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        tabs: List<Widget>.generate(_category.length,
                            (int index) {
                          return new Tab(text: _category[index]);
                        }),
                      ),
                    ],
                  ),
                ),
                body: new TabBarView(
                  children:
                      List<Widget>.generate(_category.length, (int index) {
                    return Center(
                      child: new Text(_category[index]),
                    );
                  }),
                ))),
      ),
    );
  }
  Future fetchdata() async {
    var settings = new ConnectionSettings(
        host: 'remotemysql.com',
        port: 3306,
        user: 'dGvHHrKOPT',
        password: 'FANjLTqbHT',
        db: 'dGvHHrKOPT');
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('select * from w_category');
    var list = results.toList();
    if (!mounted) return;
    setState(() {
      for (var i = 0; i < list.length; i++) {
        _category.add(list[i]["wc_category"].toString());
        _categoryImage.add(list[i]["wc_img"].toString());
        _categoryId.add(list[i]["wc_id"].toString());
      }
    });
  }
}
