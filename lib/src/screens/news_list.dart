import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../blocs/stories_bloc.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    final bloc =
        StoriesProvider.of(context); // gets instance of StoriesProvider,
    // which gets us our context and an instance of stories bloc, which calls
    // the fetch methods of our repository class and feeds the result in to a sink

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),

      // Determines what we'll be in main area of a screen, in this case it is
      // the method below, which generates a ListView
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    // Gets relevant stream, in this case the topIds Stream
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          //Even layoutParameters are widgets, like Center here:

          return Center(child: CircularProgressIndicator());
        }

        // Puts information retrieved from Snapshot into a list ListView
        // automatically handles the rendering logic for each of its views,
        // a la onBindViewHolder in an Android RecyclerView

        return Refresh(
            child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  return NewsListTile(itemId: snapshot.data[index]);
                }));
      },
    );
  }
}
