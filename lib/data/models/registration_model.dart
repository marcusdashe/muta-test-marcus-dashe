


class RegistrationRequestModel {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String signinType;
  final String spokenLanguage;
  final String userType;
  final CountryRequest country;

  RegistrationRequestModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.signinType,
    required this.spokenLanguage,
    required this.userType,
    required this.country,
  });

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) => RegistrationRequestModel(
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    password: json['password'] as String,
    signinType: json['signinType'] as String,
    spokenLanguage: json['spokenLanguage'] as String,
    userType: json['userType'] as String,
    country: CountryRequest.fromJson(json['country'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'password': password,
    'signinType': signinType,
    'spokenLanguage': spokenLanguage,
    'userType': userType,
    'country': country.toJson(),
  };
}

class CountryRequest {
  final String name;
  final String code;
  final String flag; // Note: Flag URL is a String, not an image

  CountryRequest({
    required this.name,
    required this.code,
    required this.flag,
  });

  factory CountryRequest.fromJson(Map<String, dynamic> json) => CountryRequest(
    name: json['name'] as String,
    code: json['code'] as String,
    flag: json['flag'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code,
    'flag': flag,
  };
}


// Response Model


class RegistrationResponseModel {
  final bool error;
  final String message;
  final String refreshToken;
  final String token;
  final UserData userData;

  RegistrationResponseModel({
    required this.error,
    required this.message,
    required this.refreshToken,
    required this.token,
    required this.userData,
  });

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) => RegistrationResponseModel(
    error: json['error'] as bool,
    message: json['message'] as String,
    refreshToken: json['refreshToken'] as String,
    token: json['token'] as String,
    userData: UserData.fromJson(json['userData'] as Map<String, dynamic>),
  );
}

class UserData {
  final int v;
  final String id;
  final Country country;
  final String createdAt;
  final bool deleted;
  final String email;
  final String firstName;
  final String lastName;
  final String signinType;
  final String spokenLanguage;
  final String updatedAt;
  final String userType;
  final int userShortId;
  final bool verifiedEmail;
  final bool verifiedPhone;

  UserData({
    required this.v,
    required this.id,
    required this.country,
    required this.createdAt,
    required this.deleted,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.signinType,
    required this.spokenLanguage,
    required this.updatedAt,
    required this.userType,
    required this.userShortId,
    required this.verifiedEmail,
    required this.verifiedPhone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    v: json['__v'] as int,
    id: json['_id'] as String,
    country: Country.fromJson(json['country'] as Map<String, dynamic>),
    createdAt: json['createdAt'] as String,
    deleted: json['deleted'] as bool,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    signinType: json['signinType'] as String,
    spokenLanguage: json['spokenLanguage'] as String,
    updatedAt: json['updatedAt'] as String,
    userType: json['userType'] as String,
    userShortId: json['user_short_id'] as int,
    verifiedEmail: json['verifiedEmail'] as bool,
    verifiedPhone: json['verifiedPhone'] as bool,
  );
}

class Country {
  final String code;
  final String flag;
  final String name;

  Country({
    required this.code,
    required this.flag,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    code: json['code'] as String,
    flag: json['flag'] as String,
    name: json['name'] as String,
  );
}

// Error Response Model


class ErrorResponse {
  int code;
  List<ErrorData> data;
  String message;
  String status;

  ErrorResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.status,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      code: json['code'],
      data: (json['data'] as List)
          .map((data) => ErrorData.fromJson(data))
          .toList(),
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'data': data.map((data) => data.toJson()).toList(),
      'message': message,
      'status': status,
    };
  }
}

class ErrorData {
  Context context;
  String message;
  String type;

  ErrorData({
    required this.context,
    required this.message,
    required this.type,
  });

  factory ErrorData.fromJson(Map<String, dynamic> json) {
    return ErrorData(
      context: Context.fromJson(json['context']),
      message: json['message'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'context': context.toJson(),
      'message': message,
      'type': type,
    };
  }
}

class Context {
  String key;
  String label;
  String value;

  Context({
    required this.key,
    required this.label,
    required this.value,
  });

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      key: json['key'],
      label: json['label'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'label': label,
      'value': value,
    };
  }
}
