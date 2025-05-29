import 'package:flutter/material.dart';
import 'package:mod3/Models/user.dart';
import 'package:mod3/Screens/authenticate/authenticate.dart';
import 'package:mod3/Screens/home/home.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Cus?>(context);
    //return Home or Auth
    if(user==null)
      {
        return Authenticate();
      }
    else
      return Home();
  }
}
