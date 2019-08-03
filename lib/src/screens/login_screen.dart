import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  //build method is effectively onCreate for an Android app. It serves as the
  // jumping off point that contains all subsequent methods, or in this case,
  // widget rendering

  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          //Widgets get bloc passed to them from above, rather than from a single global instance
          emailField(bloc),
          passwordField(bloc),
          Container(margin: EdgeInsets.only(top: 25)),
          submitButton(bloc),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    //Builds a stream to add data and listen for data changed in contained widget
    return StreamBuilder(
      stream: bloc.email,
      //runs every time data comes through the stream and rebuilds returned widget, the snapshot is the
      // widget's state at that moment
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: 'you@example.com',
              labelText: 'Email Address',
              errorText: snapshot.error),
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              errorText: snapshot.error),
        );
      },
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Login'),
          color: Colors.deepPurple,
          textColor: Colors.white,

          //Question mark asks if the preceding boolean is true or false,
          // command for each are put to the left and right of the following
          // colon, respectively

          onPressed: snapshot.hasData
              ? bloc.submit()
              : null,
        );
      },
    );
  }
}
