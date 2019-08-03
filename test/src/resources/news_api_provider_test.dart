import 'package:login_screen_bloc/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  // First parameter of test function is a description of what
  // we're trying to make happen

  test('FetchTopIds returns a list of ids', () async {
    //setup of test case
    final newsApi = NewsApiProvider();

    // Feeds fake data through the real request function we wrote in the
    // class this class is testing by assigning a MockClient to that class's
    // client variable

    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    // expectation (the value returned is the first parameter
    // and the value we expect is the second)

    expect(ids, [1, 2, 3, 4]);
  });

  test('Fetch item returns an ItemModel', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};

      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}
