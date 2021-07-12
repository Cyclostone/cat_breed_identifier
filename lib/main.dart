import 'package:cat_breed_identifier/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cat Breed Identifier',
      home: MySplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
