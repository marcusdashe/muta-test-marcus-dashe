import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muta_app/common/constants/muta_colors.dart';
import 'package:muta_app/common/constants/muta_image_paths.dart';
import 'package:muta_app/common/utils/toast_helper.dart';


import '../../../bloc/language/all_languages_cubit.dart';
import '../../../data/models/get_languages_model.dart';
import 'deux_learn_language_selection_ui.dart';

// Author: Marcus Dashe <marcusdashe.developer@gmail.com>


class SpokenLanguageSelection extends StatefulWidget {

  static const routeName = '/spoken-language-selection';

  const SpokenLanguageSelection({super.key});

  @override
  State<SpokenLanguageSelection> createState() => _SpokenLanguageSelectionState();
}

class _SpokenLanguageSelectionState extends State<SpokenLanguageSelection> {

  late LanguagesCubit _languagesCubit;
  AfricanLanguage? selectedLanguage;
  List<Language> _allLanguages = [];

  @override
  void initState() {
    super.initState();
    _languagesCubit = BlocProvider.of<LanguagesCubit>(context);
    init();
  }

  Future<void> init() async {
    setState(() {
      _allLanguages = _languagesCubit.getAllPlatformLanguages;
    });
  }



  void handleChipSelection(int index, bool selected) {
    setState(() {
      if (selected) {
        selectedLanguage = availableLanguages[index];
      } else {
        selectedLanguage = null; // Deselect if tapped again
      }
    });
  }

  Widget buildChipList() {
    return Wrap(
      // debugPrint(availableCurrencies.toString());
      children: availableLanguages.asMap().entries.map((entry) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: SelectableChip(
          language: entry.value,
          selected: selectedLanguage == entry.value,
          onSelected: (selected) => handleChipSelection(entry.key, selected),
        ),
      )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MutaColors.surfaceColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final w = MediaQuery.of(context).size.width, h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MutaColors.surfaceColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: w,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            if(Navigator.canPop(context)){
                              Navigator.pop(context);
                            }
                          },
                            child: Image.asset(MutaImages.backIcon))
                      ],
                    ),
                    const SizedBox(height: 50,),
                  buildChipList(),
                  const SizedBox(height: 70,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(selectedLanguage == null){
                          showToastMessage(message: "Please select a language you speak");
                          return;
                        }
                        var status = await _languagesCubit.saveSelectedLanguage(selectedLanguage?.code);
                        if(status){
                          debugPrint(selectedLanguage?.code);
                          Navigator.of(context).pushNamed(LanguageToLearnSelectionUI.routeName);
                        } else {
                          showToastMessage(message: "Try again");
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


class AfricanLanguage {
  final String code;
  final String displayName;

  const AfricanLanguage(this.code, this.displayName);
}

List<AfricanLanguage> availableLanguages = [
  const AfricanLanguage('English', 'I speak English'),
  const AfricanLanguage('French', 'Je parle Francais'),
  const AfricanLanguage('Portuguese', 'Eu falo Portugues'),
  const AfricanLanguage('Espanyol', 'Yo hablo Espanol'),
  // Add more currencies as needed
];

class SelectableChip extends StatelessWidget {
  final AfricanLanguage language;
  final bool selected;
  final void Function(bool)? onSelected;

  const SelectableChip({
    super.key,
    required this.language,
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
        height: 40,
        child: Row(
          children: [
            Image.asset(
              _getChipIcon(language.code), // Fetching icon based on network code
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Text(
              language.displayName,
              style: TextStyle(
                fontSize: 16,
                color: selected ? MutaColors.whiteColor : MutaColors.whiteColor,
              ),
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
        side: const BorderSide(color: MutaColors.primaryColor, width: 2.0), // Thicker border for selected chip
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
      case 'English':
        return MutaImages.englishIcon;
      case 'French':
        return MutaImages.frenchIcon;
      case 'Portuguese':
        return MutaImages.portugueseIcon;
      case 'Espanyol':
        return MutaImages.espanolIcon;
      default:
        return MutaImages.englishIcon; // Provide a default icon path
    }
  }
}
