import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:muta_app/bloc/auth/login_state.dart';

import '../../../bloc/auth/login_cubit.dart';
import '../../../common/cache/local_cache.dart';
import '../../../common/constants/muta_colors.dart';
import '../../../common/constants/muta_image_paths.dart';
import '../../../common/utils/toast_helper.dart';
import '../register/un_spoken_language_selection_ui.dart';

// Author: Marcus Dashe <marcusdashe.developer@gmail.com>


class LoginWithEmailUI extends StatefulWidget {
  static const routeName = '/signin-email';

  const LoginWithEmailUI({super.key});

  @override
  State<LoginWithEmailUI> createState() => _LoginWithEmailUIState();
}

class _LoginWithEmailUIState extends State<LoginWithEmailUI> {

  final LocalCache _localCache = LocalCache();
  late LoginUserCubit _loginUserCubit;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  String? prevScreenEmail;

  // signin_email
  void _clearText(TextEditingController abtiraryController) {
    abtiraryController.clear();
  }

  @override
  void initState() {
    super.initState();
    _loginUserCubit = BlocProvider.of<LoginUserCubit>(context);

    setState(() {
      prevScreenEmail = _localCache.getValue<String>("signin_email") ?? "";
    });
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


    return Scaffold(
      backgroundColor: MutaColors.surfaceColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<LoginUserCubit, LoginUserState>(
            builder: (context, state) {
              if(state is LoginUserProgress){
                return  SizedBox(
                    height: h,
                    width: w,
                    child: const Center(child: CircularProgressIndicator(color: MutaColors.primaryColor,))
                );
              } else if(state is LoginUserSuccess){
                return buildLoginUI(w, context);
              } else if(state is LoginUserFailure){
                debugPrint(state.message);
                return buildLoginUI(w, context);
              } else {
                return buildLoginUI(w, context);
              }
            },
          )
        ),
      ),
    );
  }

  Widget buildLoginUI(double w, BuildContext ctx){
    bool isFormValid = _emailController.text.isNotEmpty
                        && _passwordController.text.isNotEmpty;

    return SizedBox(
      width: w,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        _localCache.clearKey("signin_email");

                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset(MutaImages.backIcon))
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Enter your password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MutaColors.whiteColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 40,),
            TextField(
              controller: _emailController, //..text = prevScreenEmail!,
              decoration: InputDecoration(
                hintText: 'Email',
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
                    onPressed: (){
                      _clearText(_emailController);
                    } // Call _clearText function when clicked
                ),
              ),
              style: TextStyle(color: MutaColors.buttonOutlineColor),

            ),
            const SizedBox(height: 30,),

            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey), // Adjust hint text color as needed
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Adjust border color as needed
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MutaColors.buttonOutlineColor), // Adjust focused border color as needed
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                  IconButton(
                    icon: _isPasswordVisible ?
                    const Icon(Icons.visibility, color: MutaColors.buttonOutlineColor, size: 20,) :
                    const Icon(Icons.visibility_off, color: MutaColors.buttonOutlineColor, size: 20),
                    onPressed: (){
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
              ),
              style: TextStyle(color: MutaColors.buttonOutlineColor),

            ),
            SizedBox(height: 10,),
            Row(
              children: [
                InkWell(
                  onTap: (){

                  },
                    child: const Text("Forgot your password?", style: TextStyle(color: MutaColors.buttonOutlineColor),))
              ],
            ),
            const SizedBox(height: 80,),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {

                  bool hasInternetConnection = await InternetConnection().hasInternetAccess;
                  if(!hasInternetConnection){
                    showToastMessage(message: 'Please check your internet connection');
                    return;
                  }

                  if(isFormValid){
                    await _loginUserCubit.loginUser(
                        _emailController.text,
                        _passwordController.text,
                        context
                    );
                  } else {
                    showToastMessage(message: "Please enter login email and password");
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
                    Text("log in".toUpperCase(), style: const TextStyle(color: MutaColors.surfaceColor, fontSize: 18, fontWeight: FontWeight.w600),)
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
                          text: "Don't have a Muta account? ",
                          style: TextStyle(
                              color: MutaColors.textColor,
                              fontWeight: FontWeight.w400
                          ),

                        ),
                        TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                                color: MutaColors.buttonOutlineColor,
                                fontWeight: FontWeight.w500

                            ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.of(context).pushNamed(SpokenLanguageSelection.routeName);
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
    );
  }
}
