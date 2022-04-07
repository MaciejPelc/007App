import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_app/screens/authLook.dart';
import 'package:new_app/screens/wrappers.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Wrapper()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/lottie/start.json'),
    );
  }
}
