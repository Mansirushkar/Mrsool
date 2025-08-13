import 'package:flutter/material.dart';

class AppLocales {
  static const Locale enUS = Locale('en', 'US');
  static const Locale arSA = Locale('ar', 'SA');

  static const List<Locale> supported = [enUS, arSA];
  static const Locale fallback = enUS;

  static String encode(Locale l) => '${l.languageCode}_${l.countryCode}';
  static Locale decode(String code) {
    final p = code.split('_');
    return p.length == 2 ? Locale(p[0], p[1]) : fallback;
  }
}
