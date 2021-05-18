import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

confirmedButtonPressed(context, String text, String page) {
  Alert(
    image: Icon(
      Icons.check,
      color: Colors.green,
      size: 60,
    ),
    style: AlertStyle(
      backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      animationDuration: Duration(milliseconds: 300),
      titleStyle: GoogleFonts.poppins(
        color: Theme.of(context).errorColor,
        fontSize: 18,
      ),
    ),
    context: context,
    title: text,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        onPressed: () {
          page != null
              ? Navigator.pushNamedAndRemoveUntil(
                  context, '$page', (route) => false)
              : Get.back();
        },
        width: 80,
        color: Colors.green,
      )
    ],
  ).show();
}
