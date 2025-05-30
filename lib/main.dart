import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mod3/Models/user.dart';
import 'package:mod3/Screens/home/history.dart';
import 'package:mod3/Screens/home/home.dart';
import 'package:mod3/Screens/wrapper.dart';
import 'package:mod3/Services/auth.dart';
import 'package:provider/provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Cus?>.value(
      value:AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
