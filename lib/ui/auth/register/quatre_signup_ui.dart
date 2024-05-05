import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muta_app/bloc/auth/register_user_cubit.dart';

import '../../../common/cache/local_cache.dart';
import '../../../common/constants/muta_colors.dart';
import '../../../common/constants/muta_image_paths.dart';
import '../login/un_login_ui.dart';
import 'cinq_signup_email_ui.dart';


// Author: Marcus Dashe <marcusdashe.developer@gmail.com>


class SignUpUI extends StatefulWidget {
  static const routeName = '/signup-without-email';
  const SignUpUI({super.key});

  @override
  State<SignUpUI> createState() => _SignUpUIState();
}

class _SignUpUIState extends State<SignUpUI> {
  final LocalCache _localCache = LocalCache();
  late RegisterUserCubit _registerUserCubit;

  final TextEditingController _emailController = TextEditingController();

// Clear the text when the cancel icon is clicked
  void _clearText() {
    _emailController.clear();
  }

  @override
  void initState() {
    super.initState();
    _registerUserCubit = BlocProvider.of<RegisterUserCubit>(context);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MutaColors.surfaceColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final double w = MediaQuery.of(context).size.width, h = MediaQuery.of(context).size.height;

    return
      Scaffold(
      backgroundColor: MutaColors.surfaceColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: w,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            if (Navigator.canPop(context)) {
                              _localCache.clearKey("proficiency_level");

                              Navigator.pop(context);
                            }
                          },
                          child: Image.asset(MutaImages.backIcon))
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Sign up and start learning right away!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MutaColors.whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 40,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {

                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(MutaColors.whiteColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: MutaColors.whiteColor, width: 1.0),
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              left: 0,
                                child:   Image.asset(
                                  MutaImages.googleIcon, // Replace 'your_image_asset_path.png' with the path to your image
                                  width: 24, // Adjust width as needed
                                  height: 24, // Adjust height as needed
                                ),


                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: <Widget>[
                                //
                                //     const SizedBox(width: 8), // Add some space between the image and text
                                //
                                //   ],
                                // ),
                            ),
                            Positioned(

                                child: Text(
                                        "sign up with google".toUpperCase(),
                                        style: const TextStyle(color: MutaColors.surfaceColor, fontSize: 18, fontWeight: FontWeight.w600),
                                      ),
                            )
                          ],
                        ),
                      )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {

                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(MutaColors.whiteColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: MutaColors.whiteColor, width: 1.0),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: w,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                left: 0,
                                child:   Image.asset(
                                  MutaImages.facebookIcon, // Replace 'your_image_asset_path.png' with the path to your image
                                  width: 24, // Adjust width as needed
                                  height: 24, // Adjust height as needed
                                ),


                              ),
                              Positioned(

                                child: Text(
                                  "sign up with facebook".toUpperCase(),
                                  style: const TextStyle(color: MutaColors.surfaceColor, fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 50,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.grey, // Adjust color as needed
                          thickness: 1.0, // Adjust thickness as needed
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: MutaColors.buttonOutlineColor, // Adjust color as needed
                            fontWeight: FontWeight.bold, // Adjust font weight as needed
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey, // Adjust color as needed
                          thickness: 1.0, // Adjust thickness as needed
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter email address',
                      hintStyle: TextStyle(color: Colors.grey), // Adjust hint text color as needed
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey), // Adjust border color as needed
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MutaColors.buttonOutlineColor), // Adjust focused border color as needed
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: IconButton(
                        icon: Icon(FontAwesomeIcons.x, color: MutaColors.buttonOutlineColor, size: 12,), // Add cancel icon
                        onPressed: _clearText, // Call _clearText function when clicked
                      ),
                    ),
                    style: TextStyle(color: MutaColors.buttonOutlineColor),

                  ),
                  const SizedBox(height: 50,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {

                        // if(selectedProficiencyLevel == null){
                        //   showToastMessage(message: "Please rate your proficiency");
                        //   return;
                        // }

                        var status = await _registerUserCubit.cacheEmailSignUp(_emailController.text);
                        if(status){
                          Navigator.of(context).pushNamed(SignUpWithEmailUI.routeName);
                        } else {
                          Navigator.of(context).pushNamed(SignUpWithEmailUI.routeName);
                        }

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
                          Text("sign up with email".toUpperCase(), style: const TextStyle(color: MutaColors.surfaceColor, fontSize: 18, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            children: [

                              TextSpan(
                                text: "Already a Muta user? ",
                                style: TextStyle(
                                    color: MutaColors.textColor,
                                    fontWeight: FontWeight.w400
                                ),

                              ),
                              TextSpan(
                                  text: 'Log in',
                                  style: const TextStyle(
                                      color: MutaColors.buttonOutlineColor,
                                      fontWeight: FontWeight.w500

                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    Navigator.of(context).pushNamed(LoginUI.routeName);
                                  }
                              ),

                            ]
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
