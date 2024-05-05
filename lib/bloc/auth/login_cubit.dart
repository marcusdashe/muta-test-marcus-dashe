
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muta_app/common/utils/predicate.dart';
import 'package:muta_app/data/models/login_model.dart';

import '../../common/cache/local_cache.dart';
import '../../common/utils/toast_helper.dart';
import '../../data/repository/auth_repository.dart';
import '../../ui/dashboard/indexing_bottom_navigation.dart';
import 'login_state.dart';

class LoginUserCubit extends Cubit<LoginUserState>{

  final LocalCache _localCache = LocalCache();

  final AuthRepository _authRepository;

  LoginUserCubit(this._authRepository) : super(LoginUserIdle());

  Future<void> loginUser(String? email, String? password, BuildContext ctx) async {
      emit(LoginUserProgress());

      if(!areAllNonNull([email, password])){
        showToastMessage(message: 'Invalid value');
        return;
      }

      debugPrint("==> $email $password");

      LoginRequestModel loginRequestPayload = LoginRequestModel(
          email: email!,
          password: password!);

      try{
        final result = await _authRepository.login(loginRequestPayload);
        if(result.token.isNotEmpty){
          showToastMessage(message: "Login successful");
          emit(LoginUserSuccess(result));
          if (!ctx.mounted) return;
          Navigator.of(ctx).pushReplacementNamed(DashboardIndexNavigation.routeName);
        } else {
          emit(LoginUserFailure("Invalid response"));
        }
      } catch (e){
        emit(LoginUserFailure(e.toString()));
        showToastMessage(message: e.toString());
      }
  }

  Future<bool> cacheEmailSignUp(String? email) async {
    if(email == null && !isEmailAddressValid(email!) ){
      showToastMessage(message: "Invalid input");
      return false;
    }
    _localCache.getValue<String>("signin_email") ?? _localCache.saveValue<String>("signin_email", email);

    return true;
  }

}