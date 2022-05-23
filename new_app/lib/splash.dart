import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_app/screens/log_in.dart';
import 'package:new_app/screens/wrappers.dart';
import 'package:new_app/services/auth.dart';
import 'package:provider/provider.dart';

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
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AuthService(), child: Wrapper()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/lottie/start.json'),
    );
  }
}
