import 'package:rxdart/rxdart.dart';
import '../models/ItemModel.dart';
import '../resources/repository.dart';
import 'dart:async';


class StoriesBloc {

  // Subjects extend StreamControllers, which provide the sink (where data is
  // passed into a Bloc and stream (where data is acted upon and passed to the
  // view) for a given data set

  // Underscored methods and variables make them private to a class

  final _topIds = PublishSubject<List<int>>();

  // Instance of repository, our data fetching class

  final _repository = Repository();


  // Getters to get the Streams

  // Opens an access point to the stream of the _topIds StreamController/Subject

  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    // Fetches top IDs from data source then passes them into the sink of the
    // _topIds StreamController/Subject, where it will be manipulated

    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  //Transformers act upon the data in the stream each time new data is added,
  // e.g. validating the contents of a text field, or calling a method with a
  // value from the sink like we're doing below with the ID number

  _itemsTransformer() {
    return ScanStreamTransformer(
            (Map<int, Future<ItemModel>>cache, int id,_ ) {

        },
        <int, Future<ItemModel>>{

        },


    );
  }

  dispose() {
    _topIds.close();
  }


}