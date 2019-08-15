import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import '../widgets/loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
        stream: bloc.items,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }

          return FutureBuilder(
            // Get data from stream with passed id

            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              }

              // Returns title of item with that ID

              return buildTile(itemSnapshot.data);
            },
          );
        });
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}')
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
