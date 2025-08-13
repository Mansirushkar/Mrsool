import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/const_preferences.dart';
import 'app/utils/theme_data.dart';

// 🔤 localization
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/localization/app_translations.dart';
import 'app/localization/locales.dart';
import 'app/modules/language/controllers/language_controller.dart';

// Shorebird (uncomment if you're ready to use it)
// import 'package:shorebird_code_push/shorebird_code_push.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Theme
  final bool isDark = await ConstPreferences.getTheme() ?? false;
  final ThemeMode themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

  // 🔧 Make LanguageController available globally
  Get.put(LanguageController(), permanent: true);

  // Shorebird OTA init (optional)
  // final shorebirdCodePush = ShorebirdCodePush();
  // await shorebirdCodePush.initialize();

  runApp(MyApp(themeMode: themeMode));
}

class MyApp extends StatelessWidget {
  final ThemeMode themeMode;
  const MyApp({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LanguageController>();

    return Obx(() => GetMaterialApp(
      title: 'Mrsool',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,

      // 🔤 Translations
      translations: AppTranslations(),
      locale: lang.currentLocale.value,
      fallbackLocale: AppLocales.fallback,
      supportedLocales: AppLocales.supported,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      // 🎨 Theme
      themeMode: themeMode,
      theme: AppThemeData.themeData(fontFamily: 'Raleway'),
      darkTheme: AppThemeData.themeData(fontFamily: 'Raleway', lightTheme: false),
    ));
  }
}
