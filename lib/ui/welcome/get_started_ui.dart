
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/language/all_languages_cubit.dart';
import '../../common/constants/muta_colors.dart';
import '../../common/constants/muta_image_paths.dart';
import '../../data/models/get_languages_model.dart';
import '../auth/login/un_login_ui.dart';
import '../auth/register/un_spoken_language_selection_ui.dart';


// Author: Marcus Dashe <marcusdashe.developer@gmail.com>

class GetStartedUI extends StatefulWidget {
  static const routeName = '/get-started';

  const GetStartedUI({super.key});

  @override
  State<GetStartedUI> createState() => _GetStartedUIState();
}

class _GetStartedUIState extends State<GetStartedUI> {

  late LanguagesCubit _languagesCubit;


  @override
  void initState() {
    super.initState();
    _languagesCubit = BlocProvider.of<LanguagesCubit>(context);
  }





  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MutaColors.surfaceColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: buildMainUI(),
        ),
      ),
    );
  }

  Widget buildMainUI(){
    final h = MediaQuery.of(context).size.height, w = MediaQuery.of(context).size.width;

    return SizedBox(
      width: w,
      height: h,

      child: Stack(
        children: <Widget>[
          Container(
            color: MutaColors.surfaceColor,
            width: w,
            height: h,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MutaImages.doodleImage),
                fit: BoxFit.fill
              )
            ),
            width: w,
            height: h * .5,
          ),
          SizedBox(
            height: h,
            width: w,
            child: Padding(
              padding: EdgeInsets.only(top: 230, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Learn languages from", style: TextStyle(fontSize: 20, color: MutaColors.whiteColor, fontWeight: FontWeight.w200),),
                  const SizedBox(height: 20,),
                  Image.asset(MutaImages.africaImage),
                  const SizedBox(height: 40,),
                  const Text("Muta helps you learn African languages in the easiest way", style: TextStyle(fontSize: 16, color: MutaColors.textColor, fontWeight: FontWeight.w200),),

                  const SizedBox(height: 70,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(SpokenLanguageSelection.routeName);
                        // EmailScreenSignUp
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(MutaColors.primaryColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: MutaColors.buttonOutlineColor, width: 1.0),
                            )
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("get started".toUpperCase(), style: const TextStyle(color: MutaColors.surfaceColor, fontSize: 18, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MutaColors.buttonOutlineColor,  // Set the border color
                        width: 2.0,           // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(LoginUI.routeName);
                        // WowLoginScreen
                      },
                      child: Text("log in".toUpperCase(), style: const TextStyle(color: MutaColors.buttonOutlineColor, fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 120,),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [

                          TextSpan(
                              text: "By continuing on this app, you agree to Muta's ",
                              style: TextStyle(
                                  color: MutaColors.textColor,
                                  fontWeight: FontWeight.w400
                              ),

                          ),
                          TextSpan(
                              text: 'Terms of Service',
                              style: const TextStyle(
                                color: MutaColors.buttonOutlineColor,
                                  fontWeight: FontWeight.w500

                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                // Navigator.of(context).pushNamed(SignInScreen.routeName);
                              }
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                                color: MutaColors.textColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                color: MutaColors.buttonOutlineColor,
                                  fontWeight: FontWeight.w500

                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                // Navigator.of(context).pushNamed(SignInScreen.routeName);
                              }
                          ),
                        ]
                    ),
                  )

                ],
              ),
            ),
          )

        ],
      )
    );
  }
}
