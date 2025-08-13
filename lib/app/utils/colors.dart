import 'package:flutter/material.dart';

abstract class AppColors {
  Color get primary;

  Color get onPrimary;

  Color get secondary;

  Color get onSecondary;

  Color get scaffoldBackgroundColor;

  Color get success;

  Color get error;

  Color get caption;

  Color get captionLight;

  Color get captionHint;

  Color get text;

  Color get onText;
}

class AppLightColors extends AppColors {
  @override
  // Color get primary => const Color(0xffF37421);
  Color get primary => const Color(0xff6E2C90);

  @override
  Color get onPrimary => const Color(0xffFFFFFF);

  @override
  // Color get secondary => const Color(0xffFAA51A);
  Color get secondary => const Color(0xff296CB5);

  @override
  Color get onSecondary => const Color(0xffF37421);

  @override
  Color get caption => const Color(0xff44474B);

  @override
  Color get captionLight => const Color(0xffF6F6F7);

  @override
  Color get captionHint => const Color(0xff5E5E5E);

  @override
  Color get error => const Color(0xffFF4D4C);

  @override
  Color get onText => const Color(0xffFFFFFF);

  @override
  Color get scaffoldBackgroundColor => const Color(0xffFFFFFF);

  @override
  Color get text => const Color(0xff000000);

  @override
  Color get success => const Color(0xff00A037);
}

class AppDarkColors extends AppColors {
  @override
  // Color get primary => const Color(0xffF37421); // same as light
  Color get primary => const Color(0xff6E2C90);

  @override
  Color get onPrimary => const Color(0xffFFFFFF); // white on primary

  @override
  // Color get secondary => const Color(0xffFAA51A); // same as light
  Color get secondary => const Color(0xff296CB5);

  @override
  Color get onSecondary => const Color(0xffFFFFFF); // white on dark backgrounds

  @override
  Color get caption => const Color(0xffB0B0B0); // softer gray for dark theme

  @override
  Color get captionLight => const Color(0xff192B4C); // dark background for light text

  @override
  Color get captionHint => const Color(0xffA0A0A0); // subtle hint on dark

  @override
  Color get error => const Color(0xffFF4D4C); // keep red consistent

  @override
  Color get onText => const Color(0xffFFFFFF); // white text on dark bg

  @override
  Color get scaffoldBackgroundColor => const Color(0xff091222); // standard dark bg

  @override
  Color get text => const Color(0xffFFFFFF); // main text color

  @override
  Color get success => const Color(0xff00A037); // consistent green
}
