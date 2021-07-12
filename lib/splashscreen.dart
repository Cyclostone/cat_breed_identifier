import 'package:cat_breed_identifier/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: const HomePage(),
        title: const Text(
          'Cat Breed Identifier',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Colors.pink,
          ),
        ),
        image: Image.asset('assets/icon.jpg'),
        backgroundColor: Colors.white,
        photoSize: 180,
        loaderColor: Colors.red,
        loadingText: const Text(
          'From Cyclostone',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 16.0,
          ),
        ));
  }
}
