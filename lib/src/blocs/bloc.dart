import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {


  //Streams are classes that handle changes in data via sinks(the class that
  // feeds data into streams). BehaviorSubject is a type of stream

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Adds data to streams. Can optionally specify return type before
  // method like java. Attaches transformers from another class to act on the
  // data being added, such as the validation below

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  //looks at state of chosen widgets after the last change to each

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (email, password) => true);

  // Changes data in streams. Arguments passes before at the beginning of that
  // statement, as opposed to the end like Java or Kotlin

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  submit() {

    //.value gets the last value passed through the controller
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
