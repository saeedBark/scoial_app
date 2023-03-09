import 'package:flutter/material.dart';
import 'package:social_app/layout/layout.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  LayoutScreen(),
    );
  }
}

