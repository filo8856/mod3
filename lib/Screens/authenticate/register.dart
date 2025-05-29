import 'package:flutter/material.dart';
import 'package:mod3/Services/auth.dart';
class Register extends StatefulWidget {
  final Function toggle;
  const Register({super.key,required this.toggle});


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey=GlobalKey<FormState>();
  String email = '';
  String pass = '';
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.white,
        title: Text(
          'Register',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 50,
          ),
        ),
        centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.login),
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
                  validator: (val)=>val!.isEmpty?'Enter Email':null,
                  onChanged: (val) {
                    setState(() {
                      email = val.trim();
                    });
                  },
                ),
                SizedBox(height: 40),
                TextFormField(
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
                      if(_formkey.currentState!.validate())
                        {
                          dynamic result= await _auth.regemail(email, pass);
                          if(result==null)
                            {
                              setState(() {
                                error='Invalid Email or password';
                              });
                            }
                        }
                    },
                    child: Text(
                      'Register',
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
