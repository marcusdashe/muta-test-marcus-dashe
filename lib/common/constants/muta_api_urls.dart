

import '../utils/muta_config.dart';

class MutaEndpoints {


  static const String baseUrl = "${MutaConfigs.domainUrl}/";

//   Auth related endpoints
  static const String urlLogin = "${baseUrl}login";
  static const String urlCreateUser = "${baseUrl}create-user";

//   Language related endpoints
  static const String urlGetAllLanguages = "${baseUrl}get-all-languages";
}