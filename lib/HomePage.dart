import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _platformVersion = 'Unknown';
  TextEditingController _message = TextEditingController();
  TextEditingController _phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D2328),
      //AppBar
      appBar: AppBar(
        title: const Text(
          'Pinnacle - Whatsapp Direct',
          style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16, color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset(
            'assets/whatsapp.png',
            height: 20,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xff1D2328),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),

          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/img.svg',
                  height: 200,
                ),
                SizedBox(height: 25),
                Text(
                  'Send Messages in Whatsapp without Saving the Contact',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white54),
                ),
                SizedBox(height: 50),
                Text(
                  'You are on: $_platformVersion\n',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white),
                ),
                TextFormField(
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.message, color: Colors.white),
                      hintText: 'Hey where are You!',
                      labelText: 'Message ',
                      labelStyle: TextStyle(color: Colors.white54),
                      hintStyle: TextStyle(color: Colors.white54)),
                  controller: _message,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.phone_android, color: Colors.white),
                      hintText: '+91xxxxxxx',
                      labelText: 'Phone Number (With Country Code)',
                      hintStyle: TextStyle(color: Colors.white54),
                      labelStyle: TextStyle(color: Colors.white54)),
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value.length < 10 || value.isEmpty) {
                      return 'Please enter 10 Digit Phone Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      highlightColor: Colors.teal,
                      color: Colors.black,
                      onPressed: () {
                        _message.clear(); //Clear value
                        _phone.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Data's Erased")));

                      },
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      highlightColor: Colors.teal,
                      color: Colors.black,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          //Clear value
                          // If the form is valid, display a snackbar. In the real world,
                          FlutterOpenWhatsapp.sendSingleMessage(
                              "${_phone.text}", "${_message.text}");

                          print("+91${_phone.text}\n${_message.text}");

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Something went Wrong')),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
