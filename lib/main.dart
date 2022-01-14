import 'dart:ui';

import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmer Effect',
      scrollBehavior: TouchAndMouseScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class TouchAndMouseScrollBehavior extends MaterialScrollBehavior {
    // Override behavior methods and getters like dragDevices
    @override
    Set<PointerDeviceKind> get dragDevices => { 
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
      // etc.
    };
  }