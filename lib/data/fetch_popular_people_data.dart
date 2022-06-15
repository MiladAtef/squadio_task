import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/error_model.dart';
import '../models/popular_person_model.dart';

class PopularPeopleRepo {
  Future<List<dynamic>> getPopularPeople(int page) async {
    // https://api.themoviedb.org/3/person/popular?api_key=0a574ad832a42545f0a6aa2e1e16b113&page=1
    var res = await http.get(Uri.parse('$baseUrl/person/popular$apiKey&page=${page.toString()}'));
    if (res.statusCode == 200) {
      return [
        (jsonDecode(res.body)['results'] as List).map((list) => PopularPersonModel.fromJson(list)).toList(),
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw FetchDataError("Something went wrong!");
    }
  }
}
