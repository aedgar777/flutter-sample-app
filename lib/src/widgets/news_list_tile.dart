import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';


class NewsListTile extends StatelessWidget {

  final int itemId;

  NewsListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
        stream: bloc.items,
        builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>>snapshot) {
          if (!snapshot.hasData) {
            return Text('Stream still loading');
          }

          return FutureBuilder(

            // Get data from stream with passed id

            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel>itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text('Still loading item $itemId');
              }


              // Returns title of item with that ID

              return Text(itemSnapshot.data.title);
            },
          );
        }
    );
  }

}