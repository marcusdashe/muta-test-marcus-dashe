


import 'dart:convert';

import 'package:muta_app/common/constants/muta_api_urls.dart';

import '../../common/cache/local_cache.dart';
import '../../common/exception/auth_related_exceptions.dart';
import '../models/login_model.dart';
import '../models/registration_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {

  LocalCache _localCache = LocalCache();

  Future<RegistrationResponseModel>  createUser(RegistrationRequestModel payload) async {

    final response = await http.post(Uri.parse(MutaEndpoints.urlCreateUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload.toJson())
    );
    if(response.statusCode == 200){
      return RegistrationResponseModel.fromJson(jsonDecode(response.body));
    } else if(response.statusCode == 400){
      throw UserAlreadyRegisteredException(errorResponse: ErrorResponse.fromJson(jsonDecode(response.body)));
    } else {
      throw Exception("Oooops! error - Failed to create user: ${response.body}");
    }
  }

  Future<RegistrationResponseModel>  login(LoginRequestModel payload) async {

    final response = await http.post(Uri.parse(MutaEndpoints.urlLogin),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload.toJson())
    );
    if(response.statusCode == 200){
      return RegistrationResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Oooops! error - Failed to login user: ${response.body}");
    }
  }
}