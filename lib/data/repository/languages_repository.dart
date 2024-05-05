

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../common/constants/muta_api_urls.dart';
import '../models/get_languages_model.dart';

class LanguagesRepository {

  Future<LanguageResponseModel>  getAllLanguages() async {

    final response = await http.get(
        Uri.parse(MutaEndpoints.urlGetAllLanguages),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
      return LanguageResponseModel.fromJson(jsonDecode(response.body));
    } else  {
      throw Exception("Oooops! error - Failed to fetch all languages: ${response.body}");
    }
  }


}