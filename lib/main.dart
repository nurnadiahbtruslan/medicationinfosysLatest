import 'package:flutter/material.dart';
import 'package:medicationinfosys/wrapper.dart';
import 'package:medicationinfosys/auth.dart';
import 'package:provider/provider.dart';
import 'package:medicationinfosys/user.dart';
import 'homepage.dart';

void main(){
  runApp(MedApp());
}

class MedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
          
          
          child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

  /*Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName:(ctx) =>HomePage(),
        
      },
    );
  }
}*/

