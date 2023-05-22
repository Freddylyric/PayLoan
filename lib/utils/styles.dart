



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color primaryColor = Color(0xff0065C1);
final Color secondaryColor = Color(0xffF70504);
final Color backgroundColor = Color(0xffCED9F7);

class ButtonStyleConstants {

  static const double buttonHeight = 60.0;
  static const double buttonWidth = 350.0;
  static const double smallButtonHeight = 50.0;
  static const double smallButtonWidth = 100.0;
  static const double borderRadius = 16.0;
  static const EdgeInsetsGeometry buttonPadding =
  EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0);
  static const Color primaryColor = Color(0xff0065C1);
  static const Color secondaryColor = Color(0xffCED9F7);

  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    padding: buttonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    minimumSize: const Size(buttonWidth, buttonHeight),
  );

  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    padding: buttonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    minimumSize: const Size(buttonWidth, buttonHeight),
  );
  static final ButtonStyle smallButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    padding: buttonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    minimumSize: const Size(smallButtonWidth, smallButtonHeight),

  );
}



const blueBigText = TextStyle(
  fontFamily: 'Guerrer Light',
  fontSize: 24,
  fontWeight: FontWeight.w500,
  height: 1.23,
  letterSpacing: 1,
  color: Color(0xff0065C1),
);

const redText = TextStyle(
    fontFamily: 'Guerrer Light',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 1,
    color: Color(0xffF70504)
);

const redUnderlinedText = TextStyle(
    fontFamily: 'Guerrer Light',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 1,
    color: Color(0xffF70504),
    decoration: TextDecoration.underline
);

const whiteText = TextStyle(
    fontFamily: 'Guerrer Light',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 1,
    color: Colors.white
);

const blackText = TextStyle(
    fontFamily: 'Guerrer Light',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 1,
    color: Colors.black
);
const blueSmallText = TextStyle(
    fontFamily: 'Guerrer Light',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 1,
    color: Color(0xff0065C1)
);



const blueUnderlinedText = TextStyle(
    fontFamily: 'Guerrer Light',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 1,
    color: Color(0xff0065C1),
    decoration: TextDecoration.underline
);


