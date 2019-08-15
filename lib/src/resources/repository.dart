import '../models/item_model.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import 'dart:async';

//Single class to store all data sources a query might come from, and specify
// logic for each
class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[newsDbProvider];

  Future<List<int>> fetchTopIds() {
    //The implementation of this function for NewsDbProvider is deliberately
    // missing from this sample for simplicity

    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    //Loops through sources in order (offline first) until it finds the item
    // we're looking for, then it breaks out, returns it, and Caches it

    for (source in sources) {
      //Since both classes that implement Source have a fetchItem method, the
      // appropriate one will be called depending on which source the loop is
      // currently examining
      item = await source.fetchItem(id);

      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if ((cache as Source) != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

// Abstract classes require that all classes that implement them contain specified
// characteristics or methods. This makes it easy to scale a project by
// requiring things to remain consistent

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel itemModel);

  Future<int> clear();
}
