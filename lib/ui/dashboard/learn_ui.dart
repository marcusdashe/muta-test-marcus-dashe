import 'package:flutter/material.dart';

import '../../common/constants/muta_colors.dart';


// Author: Marcus Dashe <marcusdashe.developer@gmail.com>

class LearnUI extends StatefulWidget {
  const LearnUI({super.key});

  @override
  State<LearnUI> createState() => _LearnUIState();
}

class _LearnUIState extends State<LearnUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MutaColors.secondaryVariantColor,
    );
  }
}
