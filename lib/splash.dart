import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Stack(
          children: [
            // Positioned.fill(child: Image.asset('assets/images/unsplash.png',fit: BoxFit.fill,)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(),
                  ),
                  Lottie.asset('assets/animation/splash.json'),
                  Flexible(
                    child: Text(
                      'Send Messages in Whatsapp without Saving the Contact',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.grey[700]),
                    ),
                  ),

                  Expanded(
                    flex: 5,
                    child: Container(),
                  ),
                  // Image.asset('assets/images/m-text.png',height: 60,),
                  Text(
                    'Pinnacle',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: Colors.grey[700]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, () async {
      await Navigator.pushReplacementNamed(context, '/home');
    });
  }
}
