import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
        child: MaterialApp(
      title: 'News',

      //Holds logic that
      onGenerateRoute: routes,
    ));
  }

  Route routes(RouteSettings settings) {
    //provides list of routes that can possibly be taken in the app, i.e. list
    // of activities. Routes are specified in the onTap method of other activities

    switch (settings.name) {
      case "/":
        {
          return MaterialPageRoute(
            builder: (context) {
              return NewsList();
            },
          );
        }
        break;

      default:
        {
          return MaterialPageRoute(
            builder: (context) {
             final itemId = int.parse(settings.name.replaceFirst('/', ''));

              return NewsDetail(
                itemId: itemId,
              );
            },
          );
        }
        break;
    }
  }
}
