

import '../../data/models/registration_model.dart';

class UnauthorisedException implements Exception {
  final String? message;

  UnauthorisedException({required this.message});
}

class UserAlreadyRegisteredException implements Exception {
  final ErrorResponse? errorResponse;

  UserAlreadyRegisteredException({required this.errorResponse});
}