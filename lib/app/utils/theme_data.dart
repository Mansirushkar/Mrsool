import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/app/utils/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'colors.dart';

class AppThemeData {
  static ThemeData themeData({
    String? fontFamily,
    bool lightTheme = true,
  }) {
    final colors = lightTheme ? AppLightColors() : AppDarkColors();

    // Build your custom text theme first
    final customTextTheme =
    AppTextTheme().myTextTheme(fontFamily: fontFamily, colors: colors);

    // ✅ Force sane defaults: dark text on light, light text on dark.
    final fixedTextTheme = customTextTheme.apply(
      bodyColor: lightTheme ? Colors.black : Colors.white,
      displayColor: lightTheme ? Colors.black : Colors.white,
    );

    return ThemeData(
      // AppBar statusbar icons/colors
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: colors.scaffoldBackgroundColor,
          statusBarBrightness: lightTheme ? Brightness.dark : Brightness.light,
          statusBarIconBrightness:
          lightTheme ? Brightness.dark : Brightness.light,
        ),
        // Foreground (title/back icons) should match text rules
        foregroundColor: lightTheme ? Colors.black : Colors.white,
        backgroundColor: colors.scaffoldBackgroundColor,
        elevation: 0,
      ),

      // ✅ Use the fixed text theme everywhere
      textTheme: fixedTextTheme,
      primaryTextTheme: fixedTextTheme,
      // (optional) apply to icon colors used in TextButtons etc.
      iconTheme: IconThemeData(
        color: lightTheme ? Colors.black : Colors.white,
      ),

      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.scaffoldBackgroundColor,

      // ✅ ColorScheme drives many defaults (e.g., text on surfaces)
      colorScheme: Methods.colorScheme(colors: colors, lightTheme: lightTheme),

      // Cursor & selection colors
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
        selectionHandleColor: colors.primary,
        selectionColor: colors.primary.withValues(alpha: 0.25), // ✅ new method
      ),

      // Optional: make actual BottomSheet use white + rounded corners by default
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      /* If/when you re‑enable:
      inputDecorationTheme:
          Methods.inputDecorationTheme(colors: colors),
      elevatedButtonTheme:
          Methods.elevatedButtonTheme(colors: colors),
      textButtonTheme:
          Methods.textButtonTheme(colors: colors),
      outlinedButtonTheme:
          Methods.outlinedButtonTheme(colors: colors),
      */
    );
  }
}

class Methods {
  static ColorScheme colorScheme({dynamic colors, bool lightTheme = true}) {
    // ✅ Ensure onSurface is the main readable text color
    final onSurfaceColor = lightTheme ? Colors.black : Colors.white;

    // If your Colors class has a main text color, use that instead:
    // final onSurfaceColor = colors.text ?? (lightTheme ? Colors.black : Colors.white);

    return ColorScheme(
      brightness: lightTheme ? Brightness.light : Brightness.dark,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      error: colors.error,
      onError: colors.success,

      // These two are the important ones for readability on surfaces (cards, sheets)
      surface: colors.scaffoldBackgroundColor, // base surface color
      onSurface: onSurfaceColor,               // default text/icon on surfaces

      // Keep your extras, but they don’t control default text color
      onSecondaryContainer: colors.captionLight,
    );
  }

  static InputDecorationTheme inputDecorationTheme({dynamic colors}) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.only(top: 1),
      constraints: BoxConstraints(maxHeight: 70.px),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 1, color: colors.onPrimary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 1, color: colors.primary),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 2, color: colors.error),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 2, color: colors.error),
      ),
    );
  }

  static ElevatedButtonThemeData elevatedButtonTheme({dynamic colors}) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.px),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
    );
  }

  static TextButtonThemeData textButtonTheme({dynamic colors}) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.px),
        ),
        padding: EdgeInsets.zero,
        foregroundColor: colors.primary,
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme({dynamic colors}) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.px),
        ),
        foregroundColor: colors.text,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.all(3.5.px),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
