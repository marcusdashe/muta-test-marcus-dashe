import 'package:flutter/material.dart';

import '../../common/constants/muta_colors.dart';


// Author: Marcus Dashe <marcusdashe.developer@gmail.com>

class SessionUI extends StatefulWidget {
  const SessionUI({super.key});

  @override
  State<SessionUI> createState() => _SessionUIState();
}

class _SessionUIState extends State<SessionUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MutaColors.greenColor,
    );
  }
}
