import 'package:flutter/material.dart';
import 'package:flutter_ar_figure/cameraWithMaskFiltersScreen.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: CameraWithMaskFiltersScreen(),
      title: Text(
        'AR Face Masks App',
        style: TextStyle(
            fontSize: 55.0,
            color: Colors.deepPurpleAccent,
            fontFamily: "Signatra"),
      ),
      image: Image.asset('assets/images/icon.png'),
      backgroundColor: Colors.white,
      photoSize: 140,
      loaderColor: Colors.deepPurple,
      loadingText: Text(
        'from Rafael Filgs',
        style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 16.0,
            fontFamily: "Brand Bold"),
      ),
    );
  }
}
