import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muta_app/ui/auth/register/quatre_signup_ui.dart';

import '../../../bloc/language/all_languages_cubit.dart';
import '../../../common/cache/local_cache.dart';
import '../../../common/constants/muta_colors.dart';
import '../../../common/constants/muta_image_paths.dart';
import '../../../common/utils/toast_helper.dart';
import '../../../data/models/get_languages_model.dart';


// Author: Marcus Dashe <marcusdashe.developer@gmail.com>


class ProficiencyRatingUI extends StatefulWidget {
  static const routeName = '/language-proficiency-selection';

  const ProficiencyRatingUI({super.key});

  @override
  State<ProficiencyRatingUI> createState() => _ProficiencyRatingUIState();
}

class _ProficiencyRatingUIState extends State<ProficiencyRatingUI> {

  final LocalCache _localCache = LocalCache();
  late String learningLanguage;

  late LanguagesCubit _languagesCubit;
  ProficiencyLevel? selectedProficiencyLevel;

  @override
  void initState() {
    super.initState();
    setState(() {
      learningLanguage = _localCache.getValue<String>("learning_language_name") ?? "";
    });

    _languagesCubit = BlocProvider.of<LanguagesCubit>(context);
    init();
  }

  Future<void> init() async {
    setState(() {
      // _allLanguages = _languagesCubit.getAllPlatformLanguages;
    });
  }

  List<ProficiencyLevel> _allProficiency = [];

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MutaColors.surfaceColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    void handleChipSelection(int index, bool selected) {
      setState(() {
        if (selected) {
          selectedProficiencyLevel = availableLanguages[index];
        } else {
          selectedProficiencyLevel = null; // Deselect if tapped again
        }
      });
    }

    Widget buildChipList() {
      return Wrap(
        // debugPrint(availableCurrencies.toString());
        children: availableLanguages.asMap().entries.map((entry) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: SelectableChip(
            proficiencyLevel: entry.value,
            selected: selectedProficiencyLevel == entry.value,
            onSelected: (selected) => handleChipSelection(entry.key, selected),
          ),
        )).toList(),
      );
    }

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
                              _localCache.clearKey("learning_language_name");
                              _localCache.clearKey("learning_language_id");
                              Navigator.pop(context);
                            }
                          },
                          child: Image.asset(MutaImages.backIcon))
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "How would you rate your\nproficiency in $learningLanguage",
                    style: TextStyle(
                        color: MutaColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 50,),
                  buildChipList(),
                  const SizedBox(height: 70,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        debugPrint(selectedProficiencyLevel?.title);
                        if(selectedProficiencyLevel == null){
                          showToastMessage(message: "Please rate your proficiency");
                          return;
                        }
                        var status = await _languagesCubit.cacheProficiencyLevel(selectedProficiencyLevel?.title);
                        if(status){
                          Navigator.of(context).pushNamed(SignUpUI.routeName);
                        } else {
                          showToastMessage(message: "Please try again");
                        }


                        //
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


class ProficiencyLevel {
  final String title;
  final String description;
  final String proficiencyLevelImage;

  const ProficiencyLevel(this.title, this.description, this.proficiencyLevelImage);
}

List<ProficiencyLevel> availableLanguages = [
   const ProficiencyLevel('Novice', 'New to ', MutaImages.backIcon),
   const ProficiencyLevel('Beginner', 'Some words in ', MutaImages.backIcon),
   const ProficiencyLevel('Intermediate', 'Conversion in ', MutaImages.backIcon),

  // Add more currencies as needed
];

class SelectableChip extends StatelessWidget {

  final LocalCache _localCache = LocalCache();

  final ProficiencyLevel proficiencyLevel;
  final bool selected;
  final void Function(bool)? onSelected;

   SelectableChip({
    super.key,
    required this.proficiencyLevel,
    required this.selected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {

    final w = MediaQuery.of(context).size.width, h = MediaQuery.of(context).size.height;

    return ChoiceChip(
      key: key,
      label: Container(
        color: MutaColors.surfaceColor,
        width: w,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              _getChipIcon(proficiencyLevel.title), // Fetching icon based on network code
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proficiencyLevel.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: selected ? MutaColors.buttonOutlineColor: MutaColors.whiteColor,
                  ),
                ),
                Text(
                  "${proficiencyLevel.description}${_localCache.getValue<String>("learning_language_name")}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: selected ? MutaColors.buttonOutlineColor : MutaColors.whiteColor,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: MutaColors.surfaceColor, // Darker color for selected chip
      backgroundColor: MutaColors.surfaceColor, // Lighter color for unselected chip
      showCheckmark: true,
      checkmarkColor: MutaColors.whiteColor,
      shape: selected ? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: MutaColors.buttonOutlineColor, width: 2.0), // Thicker border for selected chip
      ) : null,
      // Color for the border of the selected chip
      labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      // side: BorderSide,
    );
  }

  String _getChipIcon(String code) {
    // You need to implement logic here to return the icon path based on the network code
    // For example, you can use a switch statement or a map to match the network code to the icon path
    // This is just a placeholder function
    switch (code) {
      case 'Novice':
        return MutaImages.noviceIcon;
      case 'Beginner':
        return MutaImages.beginnerIcon;
      case 'Intermediate':
        return MutaImages.intermediateIcon;
      default:
        return MutaImages.noviceIcon; // Provide a default icon path
    }
  }
}
