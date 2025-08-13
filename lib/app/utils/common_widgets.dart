import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/app/data/Apis/api_key_constants.dart' show ApiKeyConstants;
import 'package:flutter_module/app/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'common_methods.dart';

class CommonWidgets {
  static appBar({
    Widget? leading,
    String? title,
    bool? centerTitle,
    bool wantBackButton = true,
    List<Widget>? actions,
    GestureTapCallback? backAction,
  }) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0.0,
      shadowColor: Theme.of(Get.context!).scaffoldBackgroundColor.withAlpha(20),
      surfaceTintColor:
          Theme.of(Get.context!).scaffoldBackgroundColor.withAlpha(20),
      foregroundColor:
          Theme.of(Get.context!).scaffoldBackgroundColor.withAlpha(20),
      backgroundColor:
          Theme.of(Get.context!).scaffoldBackgroundColor.withAlpha(20),
      leading: wantBackButton
          ? GestureDetector(
              onTap: backAction ?? () => Get.back(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 38.px,
                    height: 38.px,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10.px),
                      color: Theme.of(Get.context!).scaffoldBackgroundColor,
                      border: Border.all(
                        color: Theme.of(Get.context!)
                            .colorScheme
                            .onSecondaryContainer,
                        width: 2.px,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20.px,
                      color: Theme.of(Get.context!).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            )
          : leading,
      centerTitle: centerTitle ?? true,
      title: Text(
        title ?? '',
        style: Theme.of(Get.context!)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 20.px),
      ),
      actions: actions,
    );
  }

  static Widget shimmerView({double? height, double? width}) {
    return SizedBox(
      height: height ?? 64.px,
      width: width ?? double.infinity,
      child: Shimmer.fromColors(
        baseColor:
            Theme.of(Get.context!).colorScheme.onSecondary.withOpacity(.4.px),
        highlightColor: Theme.of(Get.context!).colorScheme.onSecondary,
        child: Container(
          color:
              Theme.of(Get.context!).colorScheme.onSecondary.withOpacity(.4.px),
        ),
      ),
    );
  }

  ///For Full Size Use In Column Not In ROW
  static Widget commonElevatedButton(
      {double? height,
      double? width,
      EdgeInsetsGeometry? buttonMargin,
      EdgeInsetsGeometry? contentPadding,
      double? borderRadius,
      Color? splashColor,
      bool wantContentSizeButton = false,
      Color? buttonColor,
      TextStyle? textStyle,
      double? elevation,
      TextStyle? style,
      required VoidCallback onPressed,
      required String text}) {
    return Container(
      height: wantContentSizeButton ? height : 46.px,
      width: wantContentSizeButton ? width : double.infinity,
      margin: buttonMargin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.px),
          gradient: CommonMethods.commonLinearGradientView()),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0.px,
          padding: contentPadding,
          textStyle: textStyle ??
              Theme.of(Get.context!)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.px),
          ),
          backgroundColor: buttonColor ?? Colors.transparent,
          foregroundColor: splashColor ?? Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: style ??
              Theme.of(Get.context!)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 18.px),
        ),
      ),
    );
  }

  static Widget commonTextFieldForLoginSignUP(
      {double? elevation,
      String? hintText,
      String? labelText,
      String? errorText,
      String? title,
      TextStyle? titleStyle,
      EdgeInsetsGeometry? contentPadding,
      TextEditingController? controller,
      //int? maxLines,
      double? cursorHeight,
      bool wantBorder = false,
      ValueChanged<String>? onChanged,
      FormFieldValidator<String>? validator,
      Color? fillColor,
      Color? initialBorderColor,
      double? initialBorderWidth,
      TextInputType? keyboardType,
      double? borderRadius,
      double? borderWidth,
      double? maxHeight,
      TextStyle? hintStyle,
      TextStyle? style,
      TextStyle? labelStyle,
      TextStyle? errorStyle,
      List<TextInputFormatter>? inputFormatters,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool autofocus = false,
      bool readOnly = false,
      bool hintTextColor = false,
      Widget? suffixIcon,
      Widget? prefixIcon,
      AutovalidateMode? autoValidateMode,
      int? maxLength,
      GestureTapCallback? onTap,
      bool obscureText = false,
      bool leftPaddingIfWant = true,
      FocusNode? focusNode,
      MaxLengthEnforcement? maxLengthEnforcement,
      bool? filled,
      TextAlign textAlign = TextAlign.start,
      bool isCard = false}) {
    return Container(
      decoration: BoxDecoration(
        gradient: isCard
            ? CommonMethods.commonLinearGradientView()
            : CommonMethods.commonLinearGradientViewGrey(),
        borderRadius: BorderRadius.circular(borderRadius ?? 10.px),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(.2, .2),
            color: Theme.of(Get.context!).colorScheme.onSecondaryContainer,
          ),
        ],
        color: Theme.of(Get.context!).scaffoldBackgroundColor,
      ),
      child: Container(
        margin: EdgeInsets.all(borderWidth ?? 1.4.px),
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.px),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: leftPaddingIfWant ? 14.px : 0.px),
          child: Theme(
            data: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Theme.of(Get.context!).primaryColor,
                  selectionHandleColor: Theme.of(Get.context!).primaryColor,
                  selectionColor: Theme.of(Get.context!).primaryColor),
            ),
            child: TextFormField(
              focusNode: focusNode,
              textAlign: textAlign,
              maxLengthEnforcement: maxLengthEnforcement,
              //maxLines: maxLines,
              obscureText: obscureText,
              onTap: onTap,
              maxLength: maxLength,
              obscuringCharacter: '●',
              cursorHeight: cursorHeight,
              cursorColor: Theme.of(Get.context!).primaryColor,
              autovalidateMode: autoValidateMode,
              controller: controller,
              onChanged: onChanged ??
                  (value) {
                    value = value.trim();
                    if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
                      controller?.text = "";
                    }
                  },
              validator: validator,
              keyboardType: keyboardType ?? TextInputType.streetAddress,
              readOnly: readOnly,
              autofocus: autofocus,
              inputFormatters: inputFormatters,
              textCapitalization: textCapitalization,
              style: style ??
                  Theme.of(Get.context!)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 16.px, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                errorText: errorText,
                counterText: '',
                errorStyle: errorStyle ??
                    Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                        color: Theme.of(Get.context!).colorScheme.error),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                hintText: hintText,
                labelText: labelText,
                labelStyle: labelStyle,
                fillColor: fillColor ?? Theme.of(Get.context!).primaryColor,
                filled: filled,
                contentPadding: contentPadding,
                hintStyle: hintStyle ??
                    Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(Get.context!).colorScheme.onSurface),
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static imageView({
    double? width,
    double? height,
    double? radius,
    required String image,
    String? defaultNetworkImage,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius,
    Color? color,
  }) {
    return SizedBox(
      height: height ?? 64.px,
      width: width ?? double.infinity,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8.px),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: fit ?? BoxFit.cover,
          color: color,
          errorWidget: (context, error, stackTrace) {
            return Container(
              height: height ?? 64.px,
              width: width ?? double.infinity,
              color:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(.2.px),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 8.px),
                child: Icon(Icons.error, color: Theme.of(context).primaryColor),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return SizedBox(
              height: height ?? 64.px,
              width: width ?? double.infinity,
              child: Shimmer.fromColors(
                baseColor: Theme.of(context)
                    .scaffoldBackgroundColor
                    .withOpacity(.4.px),
                highlightColor: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(.4.px),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static switchButton({bool value = false, ValueChanged<bool>? onChanged}) {
    return CupertinoSwitch(
      activeColor: Theme.of(Get.context!).primaryColor,
      value: value,
      onChanged: onChanged,
    );
  }

  static Widget commonOtpView({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    PinCodeFieldShape? shape,
    TextInputType keyboardType = TextInputType.number,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onCompleted,
    int length = 6,
    double? height,
    double? width,
    double? borderRadius,
    double? borderWidth,
    bool readOnly = false,
    bool autoFocus = true,
    bool enableActiveFill = true,
    bool enablePinAutofill = true,
    bool autoDismissKeyboard = true,
    TextStyle? textStyle,
    Color? cursorColor,
    Color? inactiveColor,
    Color? inactiveFillColor,
    Color? activeColor,
    Color? activeFillColor,
    Color? selectedColor,
    Color? selectedFillColor,
    double? fontSize,
  }) =>
      PinCodeTextField(
        length: length,
        mainAxisAlignment: mainAxisAlignment,
        appContext: Get.context!,
        cursorColor: cursorColor ?? Theme.of(Get.context!).primaryColor,
        autoFocus: autoFocus,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters ??
            <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        readOnly: readOnly,
        textStyle: textStyle ?? Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
          fontSize: fontSize,
        ),
        autoDisposeControllers: false,
        enabled: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          inactiveColor:
              Theme.of(Get.context!).colorScheme.onSecondaryContainer,
          inactiveFillColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          activeColor: Theme.of(Get.context!).colorScheme.onSecondaryContainer,
          activeFillColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          selectedColor: Theme.of(Get.context!).colorScheme.primary,
          selectedFillColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          shape: shape ?? PinCodeFieldShape.box,
          fieldWidth: width ?? 50.px,
          fieldHeight: height ?? 50.px,
          borderWidth: borderWidth ?? 2.px,
          borderRadius: BorderRadius.circular(borderRadius ?? 12.px),
        ),
        enableActiveFill: enableActiveFill,
        controller: controller,
        onChanged: onChanged,
        enablePinAutofill: enablePinAutofill,
        onCompleted: onCompleted,
        autoDismissKeyboard: autoDismissKeyboard,
      );
/*
  static void showAlertDialog(
      {String title = StringConstants.logout,
      String content = StringConstants.wouldYouLikeToLogout,
      VoidCallback? onPressedYes}) {
    showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Get.back(),
            child: const Text(StringConstants.no),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onPressedYes,
            child: const Text(StringConstants.yes),
          ),
        ],
      ),
    );
  }*/

  static InputDecoration inputDecoration(
      {String? hintText,
      String? labelText,
      String? errorText,
      EdgeInsetsGeometry? contentPadding,
      Color? fillColor,
      TextStyle? hintStyle,
      TextStyle? labelStyle,
      TextStyle? errorStyle,
      Widget? suffixIcon,
      Widget? prefixIcon,
      bool? filled}) {
    return InputDecoration(
      errorText: errorText,
      counterText: '',
      errorStyle: Theme.of(Get.context!)
          .textTheme
          .titleMedium
          ?.copyWith(color: Theme.of(Get.context!).colorScheme.error),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      labelText: labelText,
      labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
      fillColor: Theme.of(Get.context!).primaryColor,
      // filled: filled ?? false,
      contentPadding: EdgeInsets.symmetric(vertical: 4.px, horizontal: 16.px),
      hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
      disabledBorder: border(color: Theme.of(Get.context!).colorScheme.surface),
      border: border(color: Theme.of(Get.context!).colorScheme.surface),
      errorBorder: border(color: Theme.of(Get.context!).colorScheme.surface),
      enabledBorder: border(color: Theme.of(Get.context!).colorScheme.surface),
      focusedErrorBorder: border(),
      focusedBorder: border(),
    );
  }

  static border({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: color ?? Theme.of(Get.context!).primaryColor, width: 2.px),
      borderRadius: BorderRadius.circular(14.px),
    );
  }

  static Future<bool> internetConnectionCheckerMethod() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com/'));
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  ///For Check Get Api Response
  static Future<bool> responseCheckForGetMethod({
    http.Response? response,
    bool wantSuccessToast = true,
    bool wantErrorToast = true,
  }) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (wantErrorToast) {
      if (responseMap[ApiKeyConstants.message] != null) {
        showCustomSnackbar(
            message: responseMap[ApiKeyConstants.message],
            type: SnackbarType.info);
      }
      if (responseMap[ApiKeyConstants.error] != null) {
        showCustomSnackbar(
            message: responseMap[ApiKeyConstants.error],
            type: SnackbarType.info);
      }
    }
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }

  ///For Check Post Api Response
  static Future<bool> responseCheckForPostMethod(
      {http.Response? response, bool wantSnackBar = true}) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (wantSnackBar) {
      if (responseMap[ApiKeyConstants.message] != null) {
        showCustomSnackbar(
            message: responseMap[ApiKeyConstants.message],
            type: SnackbarType.info);
      }
      if (responseMap[ApiKeyConstants.error] != null) {
        showCustomSnackbar(
            message: responseMap[ApiKeyConstants.error],
            type: SnackbarType.info);
      }
    }
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      return true;
    } else {
      return false;
    }
  }

  static void showImagePopup({required String image}) {
    Get.bottomSheet(
        backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        Column(children: [
          SizedBox(height: 40.px),
          CommonWidgets.appBar(),
          CommonWidgets.imageView(
              image: image,
              width: MediaQuery.of(Get.context!).size.width,
              height: MediaQuery.of(Get.context!).size.height / 1.2.px,
              borderRadius: BorderRadius.circular(20.px),
              fit: BoxFit.contain)
        ]),
        isScrollControlled: true);
    /*showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CommonWidgets.imageView(
              image: image,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              borderRadius: BorderRadius.circular(20.px),
              fit:  BoxFit.contain
            ),
          ),
        );
      },
    );*/
  }
}

enum ErrorAnimationType { shake, clear }
