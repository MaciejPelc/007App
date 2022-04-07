import 'package:flutter/material.dart';
import 'package:new_app/models/user.dart';
import 'package:new_app/screens/authLook.dart';
import 'package:new_app/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    //print(user.uid);

    //return Auth or home page
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
