import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

//Blocs are like ViewModels, handling all data manipulation without knowledge of
// the UI
class StoriesBloc {
  // Subjects extend StreamControllers, which provide the sink (where data is
  // passed into a Bloc and stream (where data is acted upon and passed to the
  // view) for a given data set

  final _repository = Repository(); // Instance of repository, our data fetching class
  final _topIds = PublishSubject<List<int>>(); // PublishSubject is a Subject that returns an Observable instead of a Stream
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>(); //BehaviorSubject is a Subject that gets the last value returned in a Stream
  final _itemsFetcher = PublishSubject<int>();

  // Getters for the Streams

  Observable<List<int>> get topIds => _topIds.stream; // Opens an access point to the stream of the _topIds StreamController/Subject
  Observable<Map<int, Future<ItemModel>>> get items =>_itemsOutput.stream; // Opens an access point to the stream of the _itemsOutput StreamController/Subject, which will handle individual items coming into the list view

  // Getters for sinks

  Function(int) get fetchItem => _itemsFetcher.sink.add; // Adds new item to the stream by passing it an int (id)

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput); //Create a constructor
    // for the StoriesBloc class. The pipe function automatically sends new items
    // from the itemsFetcher stream through the transformer and then into the into
    // the itemsOutput, which feeds the list item layouts
  }

  fetchTopIds() async {
    // Fetches top IDs from data source then passes them into the sink of the _topIds StreamController/Subject, where it will be manipulated

    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }


  // Transformers act upon the data in the stream each time new data is added,
  // e.g. validating the contents of a text field, or calling a method with a
  // value from the sink like we're doing below with the ID number

  _itemsTransformer() {
    // This transformer takes an id, fetches the associated item, and caches it. The list items then check against that cache so that they don't look for a item they already retrieved

    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    //Closes stream controllers to prevent data leaks

    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
