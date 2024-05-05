



import '../../data/models/registration_model.dart';

abstract class RegisterUserState {}

class RegisterUserIdle extends RegisterUserState{}

class RegisterUserProgress extends RegisterUserState{}

class RegisterUserSuccess extends RegisterUserState {
  final RegistrationResponseModel data;
  RegisterUserSuccess(this.data);
}

class RegisterUserFailure extends RegisterUserState {
  final String message;
  RegisterUserFailure(this.message);
}