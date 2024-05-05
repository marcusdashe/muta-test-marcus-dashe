

import '../../data/models/registration_model.dart';

abstract class LoginUserState {}

class LoginUserIdle extends LoginUserState{}

class LoginUserProgress extends LoginUserState{}

class LoginUserSuccess extends LoginUserState {
  final RegistrationResponseModel data;
  LoginUserSuccess(this.data);
}

class LoginUserFailure extends LoginUserState {
  final String message;
  LoginUserFailure(this.message);
}