import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/error_model.dart';
import '../models/popular_person_model.dart';

class PopularPeopleRepo {
  Future<List<dynamic>> getPopularPeople(int page) async {
    var res = await http.get(Uri.parse('$baseUrl/person/popular$apiKey&page=${page.toString()}'));
    if (res.statusCode == 200) {
      final List<PopularPersonModel> people = (jsonDecode(res.body)['results'] as List).map((list) => PopularPersonModel.fromJson(list)).toList();

      var box = Hive.box<PopularPersonModel>('people');
      for (var person in people) {
        if (!box.containsKey(person.id.toString())) {
          box.put(person.id.toString(), person);
        }
      }

      return [
        people,
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw FetchDataError("Something went wrong!");
    }
  }
}
