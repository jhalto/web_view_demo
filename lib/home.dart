// import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:web_view_demo/web_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WebView(),));
        },
          child: Text("web view"),
        ),
      ),
    );

  }
}
