import 'package:flutter/material.dart';

import 'homepage.dart';

void main(){
  runApp(MedApp());
}

class MedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName:(ctx) =>HomePage(),
        
      },
    );
  }
}
