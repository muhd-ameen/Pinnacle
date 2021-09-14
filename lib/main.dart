import 'package:flutter/material.dart';
import 'package:textd/splash.dart';
import 'HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pinnacle',
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext ctx) => SplashScreen(),
          '/home': (BuildContext ctx) => HomePage(),
        });
  }
}
