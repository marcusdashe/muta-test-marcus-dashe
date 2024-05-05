



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muta_app/bloc/auth/register_user_state.dart';
import 'package:muta_app/common/utils/predicate.dart';
import 'package:muta_app/ui/auth/login/un_login_ui.dart';

import '../../common/cache/local_cache.dart';
import '../../common/exception/auth_related_exceptions.dart';
import '../../common/utils/toast_helper.dart';
import '../../data/models/registration_model.dart';
import '../../data/repository/auth_repository.dart';

class RegisterUserCubit extends Cubit<RegisterUserState>{

  final LocalCache _localCache = LocalCache();

  final AuthRepository _authRepository;

  RegisterUserCubit(this._authRepository) : super(RegisterUserIdle());


  Future<void> registerUser(String? email, String? firstName, String? lastName, String? password, BuildContext ctx) async {
      emit(RegisterUserProgress());

     String? spokenLinguaId =  _localCache.getValue<String>("spoken_language_id");
      String? flag = _localCache.getValue<String>("flag_url");
      String? countryName = _localCache.getValue<String>("spoken_language_country");

      if(!areAllNonNull([email, firstName, lastName, password, spokenLinguaId, flag, countryName])){
        showToastMessage(message: 'Invalid value');
        return;
      }

      debugPrint("===> $email $firstName $lastName $password $spokenLinguaId $flag $countryName");

    // Create a new instance of CountryRequest
    CountryRequest countryRequest = CountryRequest(
      name: countryName!,
      code: 'NG',
      flag: flag!,
    );

    // Create a new instance of RegistrationRequestModel
    RegistrationRequestModel registrationRequest = RegistrationRequestModel(
      email: email!,
      firstName: firstName!,
      lastName: lastName!,
      password: password!,
      signinType: 'password',
      spokenLanguage: spokenLinguaId!,
      userType: 'learner',
      country: countryRequest,
    );

    try{
      final result = await _authRepository.createUser(registrationRequest);
      if(result.token.isNotEmpty){
        showToastMessage(message: "Registration was successful");
        emit(RegisterUserSuccess(result));
        if (!ctx.mounted) return;
        Navigator.of(ctx).pushReplacementNamed(LoginUI.routeName);
      } else {
        emit(RegisterUserFailure("Invalid response"));
      }
    } on UserAlreadyRegisteredException catch(e){
      showToastMessage(message: "User have account already");
      emit(RegisterUserFailure("User have account already"));
    } catch(e){
      emit(RegisterUserFailure(e.toString()));
      showToastMessage(message: e.toString());
    }

  }

  Future<bool> cacheEmailSignUp(String? email) async {
    if(email == null && !isEmailAddressValid(email!) ){
      showToastMessage(message: "Invalid input");
      return false;
    }
    _localCache.getValue<String>("signup_email") ?? _localCache.saveValue<String>("signup_email", email);
    // showToastMessage(message: "Email saved successful");
    return true;
  }

}