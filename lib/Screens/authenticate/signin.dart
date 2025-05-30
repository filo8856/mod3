import 'package:flutter/material.dart';
import 'package:mod3/Screens/loading.dart';
import 'package:mod3/Services/auth.dart';
class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn({super.key,required this.toggle});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool load=false;
  String email = '';
  String pass = '';
  String error='';
  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return load?Loading():Scaffold(
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
            key:_formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 120),
                TextFormField(
                  style: TextStyle(
                    fontSize:20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText:'Enter E-mail',
                    hintStyle: TextStyle(
                      fontSize:20,
                      color:Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black,width:3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black,width:3.0),
                    ),
                  ),
                  validator: (val)=>val!.isEmpty?'Enter Email':null,
                  onChanged: (val) {
                    setState(() {
                      email = val.trim();
                    });
                  },
                ),
                SizedBox(height: 40),
                TextFormField(
                  style: TextStyle(
                    fontSize:20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText:'Password',
                    hintStyle: TextStyle(
                      fontSize:20,
                      color:Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black,width:3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black,width:3.0),
                    ),
                  ),
                  validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
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
                    onPressed: () async {
                      setState(() {
                        load=true;
                      });
                      if(_formkey.currentState!.validate())
                      {
                        dynamic result= await _auth.SignInemail(email, pass);
                        if(result==null)
                        {
                          setState(() {
                            load=false;
                            error='Invalid Email or password';
                          });
                        }
                      }
                      else {
                        setState(() {
                          load = false;
                        });
                      }
                    },
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
                SizedBox(height: 20),
                Text(
                  error,
                  style: TextStyle(color: Colors.red,fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
