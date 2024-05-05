import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muta_app/data/repository/auth_repository.dart';
import 'package:muta_app/data/repository/languages_repository.dart';
import 'package:muta_app/ui/auth/login/deux_login_with_email.dart';
import 'package:muta_app/ui/auth/login/un_login_ui.dart';
import 'package:muta_app/ui/auth/register/cinq_signup_email_ui.dart';
import 'package:muta_app/ui/auth/register/deux_learn_language_selection_ui.dart';
import 'package:muta_app/ui/auth/register/quatre_signup_ui.dart';
import 'package:muta_app/ui/auth/register/trois_proficiency_language_selection_ui.dart';
import 'package:muta_app/ui/auth/register/un_spoken_language_selection_ui.dart';
import 'package:muta_app/ui/dashboard/indexing_bottom_navigation.dart';
import 'package:muta_app/ui/welcome/flash_ui.dart';
import 'package:muta_app/ui/welcome/get_started_ui.dart';

import 'bloc/auth/login_cubit.dart';
import 'bloc/auth/register_user_cubit.dart';
import 'bloc/language/all_languages_cubit.dart';
import 'common/cache/local_cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalCache().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

    providers: [
      BlocProvider<LanguagesCubit>(create: (context) => LanguagesCubit(LanguagesRepository())),
      BlocProvider<RegisterUserCubit>(create: (context) => RegisterUserCubit(AuthRepository())),
      BlocProvider<LoginUserCubit>(create: (context) => LoginUserCubit(AuthRepository())),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Muta Language App',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          useMaterial3: true,
        ),
        home: const FlashUI(),
        routes: {
          GetStartedUI.routeName: (context) => const GetStartedUI(),
          SpokenLanguageSelection.routeName: (context) => const SpokenLanguageSelection(),
          LanguageToLearnSelectionUI.routeName: (context) => const LanguageToLearnSelectionUI(),
          ProficiencyRatingUI.routeName: (context) => const ProficiencyRatingUI(),
          SignUpUI.routeName: (context) => const SignUpUI(),
          SignUpWithEmailUI.routeName: (context) => const SignUpWithEmailUI(),
          LoginUI.routeName: (context) => const LoginUI(),
          LoginWithEmailUI.routeName: (context) => const LoginWithEmailUI(),
          DashboardIndexNavigation.routeName: (context) => const DashboardIndexNavigation(),
        },
      ),
    );

  }
}

