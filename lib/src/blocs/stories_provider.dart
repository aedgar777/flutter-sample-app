import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart';

//Class the provides context to all Widgets in ts sub-tree

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;


  // named arguments wrapped in curly braces makes them optional
  StoriesProvider({Key key, Widget child})//This constructor provides an instance of the stories bloc to be accessed from the app
      : bloc = StoriesBloc(),
        super(key: key, child: child);  //Passes arguments to superclass


  @override
  bool updateShouldNotify(_) {

    return true;
  }

  //Goes up the hierarchy until it finds a widget of the specified type and then casts that type to "InheritedType"


  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}
