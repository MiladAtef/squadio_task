import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/cast_info_model.dart';
import '../models/error_model.dart';
import '../models/person_image_model.dart';

class FetchPersonInfoById {
  Future<List<dynamic>> getCastDetails(String id) async {
    PopularPersonInfo personalInfo;
    SocialMediaInfo socialMedia;
    ImageBackdropList backdrops;
    try {
      personalInfo = await _getPersonalInfo(id);
      socialMedia = await _getPersonSocialMedia(id);
      backdrops = await _getPersonImages(id);

      return [
        personalInfo,
        socialMedia,
        backdrops.backdrops,
      ];
    } catch (e) {
      throw FetchDataError('Failure to fetch data');
    }
  }

  Future<PopularPersonInfo> _getPersonalInfo(String id) async {
    var response = await http.get(Uri.parse('$baseUrl/person/$id$apiKey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return PopularPersonInfo.fromJson(data);
    } else {
      throw FetchDataError('Failure to fetch data');
    }
  }

  Future<SocialMediaInfo> _getPersonSocialMedia(String id) async {
    var response = await http.get(Uri.parse('$baseUrl/person/$id/external_ids$apiKey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return SocialMediaInfo.fromJson(data);
    } else {
      throw FetchDataError('Failure to fetch data');
    }
  }

  Future<ImageBackdropList> _getPersonImages(String id) async {
    var response = await http.get(Uri.parse('$baseUrl/person/$id/images$apiKey&language=en-US&include_image_language=en'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ImageBackdropList.fromJson(data['profiles']);
    } else {
      throw FetchDataError('Failure to fetch data');
    }
  }
}
