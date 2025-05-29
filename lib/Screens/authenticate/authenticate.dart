import 'package:flutter/material.dart';
import 'package:mod3/Screens/authenticate/register.dart';
import 'package:mod3/Screens/authenticate/signin.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool show=true;
  void toggle()
  {
    setState(() {
      show=!show;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(show)
      return SignIn(toggle: toggle);
    else
      return Register(toggle: toggle);
  }
}
