import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/ItemModel.dart';
import 'dart:async';
import 'dart:core';


final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();


  //Asynchronous functions have to be wrapped with the Future class

  Future<List<int>> fetchTopIds() async {

    //Gets all top stories from URL

    final response = await client.get(
        '$_root/topstories.json');


    //Converts response into json
    final ids = json.decode(response.body);

    return ids.cast<int>;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');

    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
