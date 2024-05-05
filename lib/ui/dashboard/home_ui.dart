import 'package:flutter/material.dart';
import 'package:muta_app/common/constants/muta_colors.dart';


// Author: Marcus Dashe <marcusdashe.developer@gmail.com>


class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MutaColors.primaryColor,
    );
  }
}
