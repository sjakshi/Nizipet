import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nizipet1/screen/loginscreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = Duration(seconds: 10);
    return new Timer(duration, loginRoute);
  }

  loginRoute (){
    Navigator.pushReplacement(context, MaterialPageRoute
      (builder: (context)=> LoginScreen()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  // SplashScreen
  Widget initWidget(){
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF7C9D8E),
          ),
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/splashscreen.jpg',
                  height: 600.0,
                  width: 500.0,
                ),
                // Text(
                //     'Nizi Pet',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: Color(0xFF000033),
                //     fontWeight: FontWeight.bold,
                //     fontSize: 40.0,
                //   ),
                // )
              ],
            ),
          ),
        )
    );
  }
}
