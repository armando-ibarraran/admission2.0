import 'package:flutter/material.dart';
import './scripts/start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Start(),
    );
  }
}


/*
new Expanded(
            child: new Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Hi, I'm Armando!\n\nI made this app in order to comunicate and show things I couldn't in the other elements of my application. I also coded a little tool in which you could manage and store admission profiles. I hope it's useful for you.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: "Rope",
                ),
              ),
            ),
          ),
 */