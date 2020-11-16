import 'package:flutter/material.dart';
import 'package:flutter_conference_lowlevel/conferences_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConferencesPage(),
    );
  }
}

