import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_page.dart'; 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 4), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/splash.json', 
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
            Text("TO DO APP",style: TextStyle(
              fontSize: 25,color: Colors.white
            ),),
          ],
        ),
      ),
    );
  }
}
