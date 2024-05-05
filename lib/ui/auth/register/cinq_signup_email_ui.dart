import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:muta_app/bloc/auth/register_user_state.dart';

import '../../../bloc/auth/register_user_cubit.dart';
import '../../../common/cache/local_cache.dart';
import '../../../common/constants/muta_colors.dart';
import '../../../common/constants/muta_image_paths.dart';
import '../../../common/utils/toast_helper.dart';
import '../login/un_login_ui.dart';


// Author: Marcus Dashe <marcusdashe.developer@gmail.com>

class SignUpWithEmailUI extends StatefulWidget {
  static const routeName = '/signup-with-email';

  const SignUpWithEmailUI({super.key});

  @override
  State<SignUpWithEmailUI> createState() => _SignUpWithEmailUIState();
}

class _SignUpWithEmailUIState extends State<SignUpWithEmailUI> {

  final LocalCache _localCache = LocalCache();
  late RegisterUserCubit _registerUserCubit;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? prevScreenEmail;

  void _clearText(TextEditingController abtiraryController) {
    abtiraryController.clear();
  }

  @override
  void initState() {
    super.initState();
    _registerUserCubit = BlocProvider.of<RegisterUserCubit>(context);

    setState(() {
      prevScreenEmail = _localCache.getValue<String>("signup_email") ?? "";
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
          child:BlocBuilder<RegisterUserCubit, RegisterUserState>(
            builder: (context, state) {
              if(state is RegisterUserProgress){
                return  SizedBox(
                    height: h,
                    width: w,
                    child: const Center(child: CircularProgressIndicator(color: MutaColors.primaryColor,))
                );
              } else if(state is RegisterUserSuccess){
                return buildSignUI(w, context);
              } else if(state is RegisterUserFailure){
                debugPrint(state.message);
                return buildSignUI(w, context);
              } else {
                return buildSignUI(w, context);
              }
            },

          )
          // buildSignUI(w, context),
        ),
      ),
    );
  }

  SizedBox buildSignUI(double w, BuildContext context) {
    bool isFormValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty;

    return SizedBox(
          width: w,
          child:
          Padding(
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
                            _localCache.clearKey("signup_email");

                            Navigator.pop(context);
                          }
                        },
                        child: Image.asset(MutaImages.backIcon))
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  "Enter name and password",
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
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: 'First name',
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
                          _clearText(_firstNameController);
                        } // Call _clearText function when clicked
                    ),
                  ),
                  style: TextStyle(color: MutaColors.buttonOutlineColor),

                ),
                const SizedBox(height: 30,),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: 'Last name',
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
                          _clearText(_lastNameController);
                        } // Call _clearText function when clicked
                    ),
                  ),
                  style: TextStyle(color: MutaColors.buttonOutlineColor),

                ),
                const SizedBox(height: 30,),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
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
                    suffixIcon: IconButton(
                        icon: Icon(FontAwesomeIcons.x, color: MutaColors.buttonOutlineColor, size: 12,), // Add cancel icon
                        onPressed: (){
                          _clearText(_passwordController);
                        } // Call _clearText function when clicked
                    ),
                  ),
                  style: TextStyle(color: MutaColors.buttonOutlineColor),

                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("Use 8 or more characters", style: TextStyle(color: MutaColors.greenColor),)
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
                        await _registerUserCubit.registerUser(
                            _emailController.text,
                            _firstNameController.text,
                            _lastNameController.text,
                            _passwordController.text,
                          context

                        );
                      } else {
                        showToastMessage(message: "Please enter all fields");
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
                        Text("sign up".toUpperCase(), style: const TextStyle(color: MutaColors.surfaceColor, fontSize: 18, fontWeight: FontWeight.w600),)
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
        );
  }
}
