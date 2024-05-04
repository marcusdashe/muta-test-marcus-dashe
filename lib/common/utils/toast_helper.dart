
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muta_app/common/constants/muta_colors.dart';

void showToastMessage({required String message }) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    backgroundColor: MutaColors.surfaceColor,
    textColor: Colors.white,
    fontSize: 14.0
);