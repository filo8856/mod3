import 'package:flutter/material.dart';
import 'package:mod3/Services/auth.dart';
class Home extends StatelessWidget {
final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new_rounded),
            color: Colors.black,
            iconSize: 55,
            onPressed: ()async{
              await _auth.SO();
            },
        ),
        ]
      ),
    );
  }
}
