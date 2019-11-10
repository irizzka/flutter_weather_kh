import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather/weather_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:  ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body:  RefreshIndicator(
        child:  ListView(
          children: _getItems(),
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  List<Widget> _getItems() {
    List<Widget> items = <Widget>[];
      var item = Column(
        children: <Widget>[
          WeatherOverview(),
        ],
      );
      items.add(item);

    return items;
  }

  Future<WeatherOverview> _handleRefresh() async {
    await Future<Null>.delayed( Duration(seconds: 1));
    setState(() {
    });

    return WeatherOverview();
  }
}