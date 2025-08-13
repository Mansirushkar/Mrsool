import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/const_preferences.dart';
import '../../../localization/locales.dart';

class LanguageController extends GetxController {
  static const _localeKey = 'app_locale_code';
  final currentLocale = AppLocales.fallback.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final saved = await ConstPreferences.getString(_localeKey);
    if (saved != null && saved.isNotEmpty) {
      final locale = AppLocales.decode(saved);
      currentLocale.value = locale;
      Get.updateLocale(locale);
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    currentLocale.value = locale;
    log(currentLocale.value.toString());
    Get.updateLocale(locale);
    await ConstPreferences.setString(_localeKey, AppLocales.encode(locale));
  }
}
