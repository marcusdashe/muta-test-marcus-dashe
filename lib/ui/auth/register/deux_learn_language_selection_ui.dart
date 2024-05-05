import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muta_app/ui/auth/register/trois_proficiency_language_selection_ui.dart';

import '../../../bloc/language/all_languages_cubit.dart';
import '../../../common/cache/local_cache.dart';
import '../../../common/constants/muta_colors.dart';
import '../../../common/constants/muta_image_paths.dart';
import '../../../common/utils/toast_helper.dart';


// Author: Marcus Dashe <marcusdashe.developer@gmail.com>


class LanguageToLearnSelectionUI extends StatefulWidget {
  static const routeName = '/language-learning-selection';

  const LanguageToLearnSelectionUI({super.key});

  @override
  State<LanguageToLearnSelectionUI> createState() =>
      _LanguageToLearnSelectionUIState();
}

class _LanguageToLearnSelectionUIState
    extends State<LanguageToLearnSelectionUI> {
  final LocalCache _localCache = LocalCache();
  int _selectedCardIndex = 0; // Index of the selected card, initially null

  late LanguagesCubit _languagesCubit;
  // AfricanLanguage? selectedLanguage; // Hold the selected language
  String selectedLanguageCode = '';
  String selectedLanguageName = '';

  List<Map<String, dynamic>> languages = [];

  @override
  void initState() {
    super.initState();
    _languagesCubit = BlocProvider.of<LanguagesCubit>(context);
    init();
  }

  Future<void> init() async {
    final response = _languagesCubit.getAllPlatformLanguages;
    setState(() {
      languages = response.map((lang) {
        return {
          "title": lang.languageName,
          "image": lang.languageIcon,
          "code": lang.languageCode,
          "lang_id": lang.languageId
        };
      }).toList();
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
                              _localCache.clearKey("spoken_language_id");
                              _localCache.clearKey("flag_url");
                              Navigator.pop(context);
                            }
                          },
                          child: Image.asset(MutaImages.backIcon))
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "I want to learn...",
                    style: TextStyle(
                        color: MutaColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      final language = languages[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCardIndex = index;
                            selectedLanguageCode = languages[index]['lang_id'];
                            selectedLanguageName = languages[index]['title'];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedCardIndex == index
                                  ? MutaColors.primaryColor // Brighter color when selected
                                  : Colors.grey.withOpacity(0.5), // Faint color when not selected
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0), // Reduced border radius
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  language["image"],
                                  width: 50,
                                  height: 50,
                                  // Change image appearance when selected
                                  // color: _selectedCardIndex == index
                                  //     ? MutaColors.primaryColor
                                  //     : null,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  language["title"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _selectedCardIndex == index
                                        ? MutaColors.primaryColor
                                        : MutaColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(selectedLanguageCode.isEmpty){
                          showToastMessage(message: "Please select a language you want to learn");
                          return;
                        }
                        // showToastMessage(message: selectedLanguageCode);
                        debugPrint(selectedLanguageCode);
                        var status = await _languagesCubit.cacheLanguageToLearn(selectedLanguageCode, selectedLanguageName);
                        if(status){

                          Navigator.of(context).pushNamed(ProficiencyRatingUI.routeName);
                        } else {
                          showToastMessage(message: "Try again");
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
                          Text("continue".toUpperCase(), style: const TextStyle(color: MutaColors.surfaceColor, fontSize: 18, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


