import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class CommonMethods {
  static void unFocsKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Color getRandomLightColor() {
    final Random random = Random();
    // Generate light colors with high RGB values
    int red = 200 + random.nextInt(56); // 200-255
    int green = 200 + random.nextInt(56); // 200-255
    int blue = 200 + random.nextInt(56); // 200-255
    return Color.fromARGB(255, red, green, blue);
  }

  static Color getDarkVariantOfColor(Color color) {
    final hslColor = HSLColor.fromColor(color);

    // Reduce lightness to make it dark (e.g., 0.8 -> 0.3)
    final darkHsl = hslColor.withLightness((hslColor.lightness * 0.6).clamp(0.0, 1.0));

    return darkHsl.toColor();
  }

  static Widget appIcons(
      {required String assetName,
      double? width,
      double? height,
      Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          assetName,
          height: height ?? 24.px,
          width: width ?? 24.px,
          color: color,
        ),
      ],
    );
  }

  static Widget appIconsPng(
      {required String assetName, double? width, double? height}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          assetName,
          height: height ?? 24.px,
          width: width ?? 24.px,
        ),
      ],
    );
  }

  static LinearGradient commonLinearGradientView() => LinearGradient(
        end: Alignment.centerRight,
        begin: Alignment.centerLeft,
        colors: [
          Theme.of(Get.context!).colorScheme.secondary,
          Theme.of(Get.context!).colorScheme.primary,
        ],
      );

  static LinearGradient commonLinearGradientViewGrey() => LinearGradient(
        end: Alignment.centerLeft,
        begin: Alignment.centerRight,
        colors: [
          Theme.of(Get.context!).colorScheme.onSecondaryContainer,
          Theme.of(Get.context!).colorScheme.onSecondaryContainer,
        ],
      );

  static LinearGradient commonLinearGradientViewDarkGrey() => LinearGradient(
        end: Alignment.centerLeft,
        begin: Alignment.centerRight,
        colors: [
          Color(0xffA8A8BD),
          Color(0xffA8A8BD),
        ],
      );

  static Widget textViewLinearGradient(
          {String? text, bool? value, TextStyle? style}) =>
      Center(
        child: GradientWidget(
          text: text,
          style: style ??
              Theme.of(Get.context!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 12.px, fontWeight: FontWeight.w600),
          gradient: value ?? true
              ? commonLinearGradientView()
              : commonLinearGradientViewDarkGrey(),
        ),
      );

  static Widget iconLinearGradient(
          {required String assetName,
          double? width,
          double? height,
          bool? value}) =>
      Center(
        child: GradientWidget(
          gradient: value ?? true
              ? commonLinearGradientView()
              : commonLinearGradientViewDarkGrey(),
          child: appIcons(assetName: assetName, width: width, height: height),
        ),
      );

  static Future<void> commonAndroidNoInternetDialog(
      {bool isDismiss = true, GestureTapCallback? onTap}) async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(
                //   width: 200,
                //   child: Image.asset(ImageConstants.imgNotFound),
                // ),
                const SizedBox(height: 32),
                const Text(
                  "Whoops!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  "No internet connection found.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Check your connection and try again.",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                /* const SizedBox(height: 8),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(14.px),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.px)),
                    child: Text(
                      "Click Me.",
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        );
      },
      useSafeArea: true,
      barrierDismissible: isDismiss,
    );
  }

  static void noInternet() {
    Get.snackbar(
        margin: EdgeInsets.all(20.px),
        'Error',
        'Please check your internet connection');
  }
}

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    super.key,
    this.text,
    required this.gradient,
    this.style,
    this.child,
  });

  final String? text;
  final TextStyle? style;
  final Widget? child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child ?? Text(text ?? '', style: style),
    );
  }
}
