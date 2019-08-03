import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'blocs/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Wraps widget in provider and gives all child widgets access to provider's copy of the bloc
    return Provider(
        child: MaterialApp(
      title: 'Log Me IN',
      home: Scaffold(
        body: LoginScreen(),
      ),
    )
    );
  }
}
