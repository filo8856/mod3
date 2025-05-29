import 'package:flutter/material.dart';
import 'package:mod3/Services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn({super.key,required this.toggle});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.white,
        title: Text(
          'Sign In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 50,
          ),
        ),
        centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.app_registration),
              color: Colors.black,
              iconSize: 55,
              onPressed: ()async{
                widget.toggle();
              },
            ),
          ]
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            //key:_formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 120),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 40),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      pass = val;
                    });
                  },
                ),
                SizedBox(height: 50),
                Container(
                  width: 150,
                  height: 60,
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40), // round corners
                    ),
                    onPressed: () async {},
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
