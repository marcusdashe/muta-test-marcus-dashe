


import '../../data/models/get_languages_model.dart';

abstract class LanguagesState {}

class LanguagesIdle extends LanguagesState{}

class LanguagesProgress extends LanguagesState{}

class LanguagesSuccess extends LanguagesState {
  final LanguageResponseModel data;
  LanguagesSuccess(this.data);
}

class LanguagesFailure extends LanguagesState {
  final String message;
  LanguagesFailure(this.message);
}