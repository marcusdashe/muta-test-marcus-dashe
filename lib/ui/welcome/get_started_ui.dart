
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/constants/muta_colors.dart';
import '../../common/constants/muta_image_paths.dart';



class GetStartedUI extends StatefulWidget {
  static const routeName = '/get-started';

  const GetStartedUI({super.key});

  @override
  State<GetStartedUI> createState() => _GetStartedUIState();
}

class _GetStartedUIState extends State<GetStartedUI> {
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
              padding: EdgeInsets.only(top: 230, left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Learn languages from", style: TextStyle(fontSize: 24, color: MutaColors.whiteColor, fontWeight: FontWeight.w200),),
                  const SizedBox(height: 20,),
                  Image.asset(MutaImages.africaImage),
                  const SizedBox(height: 40,),
                  const Text("Muta helps you learn African languages in the easiest way", style: TextStyle(fontSize: 16, color: MutaColors.whiteColor, fontWeight: FontWeight.w200),),
                ],
              ),
            ),
          )

        ],
      )
    );
  }
}
