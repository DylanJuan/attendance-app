import 'package:attendance_app/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Lato',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
            bodyText2: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
            subtitle1: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            subtitle2: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black54)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
