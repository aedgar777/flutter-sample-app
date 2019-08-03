import 'package:flutter/material.dart';
import 'bloc.dart';

//Class the provides context to all Widgets in ts sub-tree

class Provider extends InheritedWidget {

  //Creates new instance of our block upon creation of the provider

  final bloc = Bloc();

  Provider({Key key, Widget child})

  //Passes arguments to superclass
      :super(key: key, child: child);


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Bloc of(BuildContext context) {

    //Goes up the hierarchy until it finds a widget of the specified type and then casts that type to "InheritedType"
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }


}