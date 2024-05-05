
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muta_app/common/utils/toast_helper.dart';

import '../../common/cache/local_cache.dart';
import '../../data/models/get_languages_model.dart';
import '../../data/repository/languages_repository.dart';
import 'all_languages_state.dart';

class LanguagesCubit extends Cubit<LanguagesState>{

  final LocalCache _localCache = LocalCache();

  final LanguagesRepository _languagesRepository;

  List<Language> _allLanguages = [];

  LanguagesCubit(this._languagesRepository) : super(LanguagesIdle());

  Future<List<Language>> fetchAllLanguages() async {
        emit(LanguagesProgress());

        try{
          final response = await _languagesRepository.getAllLanguages();
          if(response.data.isNotEmpty){
            debugPrint(response.data[0].languageName);
            emit(LanguagesSuccess(response));
            _allLanguages = [...response.data];
          } else {
            emit(LanguagesFailure("Error: Empty languages"));
            debugPrint(response.error.toString());
            _allLanguages = [];
          }
        } catch (e){
          emit(LanguagesFailure(e.toString()));
          _allLanguages = [];
        }
        return _allLanguages;
  }

  Future<bool> cacheLanguageToLearn(String? languageId, String? languageName) async {
    if(languageId == null || languageName == null){
      showToastMessage(message: "Invalid input");
      return false;
    }
    _localCache.getValue<String>("learning_language_id") ?? _localCache.saveValue<String>("learning_language_id", languageId);
    _localCache.getValue<String>("learning_language_name") ?? _localCache.saveValue<String>("learning_language_name", languageName);
    showToastMessage(message: "Learning language saved successful");
    return true;
  }

  Future<bool> cacheProficiencyLevel(String? proficiencyLevel) async {

    if(proficiencyLevel == null){
      showToastMessage(message: "Invalid input");
      return false;
    }
    _localCache.getValue<String>("proficiency_level") ?? _localCache.saveValue<String>("proficiency_level", proficiencyLevel);
    return true;
  }

  Future<bool> saveSelectedLanguage(String? language) async {
    if(language == null){
      return false;
    }

    if(_allLanguages.isNotEmpty){
      for(Language lang in _allLanguages){
        if(lang.languageName == language){

          debugPrint("Language matched ${lang.languageId}");
          var selectedLanguageCountry = getCountryNameFromLanguage(lang.languageName);
          _localCache.getValue<String>("spoken_language_country") ?? _localCache.saveValue<String>("spoken_language_country", selectedLanguageCountry);
          _localCache.getValue<String>("spoken_language_id") ?? _localCache.saveValue<String>("spoken_language_id", lang.languageId);
          _localCache.getValue<String>("flag_url") ?? _localCache.saveValue<String>("flag_url", lang.languageIcon);
          showToastMessage(message: "Spoken language save successful");
          return true;
        }
      }
    } else {
      return false;
    }
    return false;
  }

  String getCountryNameFromLanguage(String languageName) {
    // Map language names to their respective countries
    Map<String, String> countryMap = {
      'Portuguese': 'Portugal',
      'French': 'France',
      'English': 'United States',
      'Espanyol': 'Spain',
      'Zulu': "South Africa",
      'Swahili': 'Kenya',
      'Igbo': 'Nigeria',
      'Yoruba': 'Nigeria'
    };

    // Check if the language name is mapped to a country
    if (countryMap.containsKey(languageName)) {
      return countryMap[languageName]!;
    } else {
      // If not mapped, return 'Unknown'
      return 'Nigeria';
    }
  }


    List<Language> get getAllPlatformLanguages => _allLanguages;

}