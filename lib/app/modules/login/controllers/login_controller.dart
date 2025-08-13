import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_module/app/services/native_data_services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/get_country_digit_map.dart';
import '../../../utils/snackbar.dart';
import '../repo/login_model.dart';
import '../repo/sign_in_method.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  var isPhoneFilled = false.obs;
  var countryCodeController = '+966'.obs;
  var countryCode = 'SA'.obs;

  final deviceToken = ''.obs;
  final deviceName = ''.obs;
  final osVersion = ''.obs;
  final appVersion = ''.obs;
  final deviceId = ''.obs;
  final latitude = ''.obs;
  final longitude = ''.obs;
  final language = ''.obs;
  final vLanguage = ''.obs;
  final appType = ''.obs;
  final deviceType = ''.obs;
  final deviceProvider = ''.obs;

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      isPhoneFilled.value = phoneController.text.trim().isNotEmpty;
    });

    NativeDataService.setNativeListener((token) {
      print("Received token from native: $token");
      deviceToken.value = token;
    });

    fetchDeviceData();
  }

  void fetchDeviceData() async {
    final token = await NativeDataService.getDeviceToken();
    final info = await NativeDataService.getDeviceInfo();

    deviceToken.value = token ?? '';
    deviceName.value = info?['deviceName'] ?? '';
    osVersion.value = info?['osVersion'] ?? '';
    appVersion.value = info?['appVersion'] ?? '';
    deviceId.value = info?['deviceId'] ?? '';
    latitude.value = info?['latitude'] ?? '';
    longitude.value = info?['longitude'] ?? '';
    language.value = info?['language'] ?? '';
    vLanguage.value = info?['vLanguage'] ?? '';
    appType.value = info?['appType'] ?? '';
    appType.value = info?['deviceProvider'] ?? '';
    deviceType.value = info?['deviceType'] ?? '';

    print("LoginController_Device InfoFlutter: $info");
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  Future<void> handleHCaptchaToken(String token) async {
    print('Received hCaptcha token in Flutter: $token');
    // TODO: Use the token for your API calls or other logic in Flutter
  }

  Future<PhoneDigitRange> getCountryPhoneDigits(String countryCode) async {
    final digitMap = await getCountryDigitMap();
    return digitMap[countryCode] ?? PhoneDigitRange(min: 9, max: 20);
  }

  Future<void> callLoginWithNumber({required String vPhone, String? hCaptchaToken}) async {
    print('LoginController LoginAPI_CALLL: $vPhone');
    print('LoginController_ :::param hCaptchaToken-  ${hCaptchaToken}');
    final Stopwatch stopwatch = Stopwatch()..start(); // Start timing
    try {
      Map<String, dynamic> bodyParams = {
        "app_type": "courier",
        "device_id": deviceToken.value,
        "vDeviceToken": deviceToken.value,
        if (hCaptchaToken != null && hCaptchaToken.isNotEmpty) "captcha_token": hCaptchaToken,
        "vTokenType": deviceProvider.value,
        "vLanguage": vLanguage.value,
        "vDeviceVersion": deviceName.value,
        "vOSVersion": osVersion.value,
        "language": language.value,
        "vPlatform": deviceType.value,
        "vPhone": vPhone,
        "vAppVersion": appVersion.value,
      };
      LoginModel? loginModel = await SignInMethod.signInApi(bodyParams: bodyParams);
      if (loginModel != null) {
        stopwatch.stop(); // Stop timing
        print('LoginController_API call took: ${stopwatch.elapsedMilliseconds} ms');
        if (loginModel.code == 200) {
          print('LoginController- Login successful!');
          print('${loginModel.message}');
          await NativeDataService.openOTPActivity(
            loginModel.userNo!,
            countryCode.value,
            vPhone,
            loginModel.iUserId!,
          ); // <-- call to open native activity
        } else {
          print('LoginController- else_UserNot registered!');
          print('${loginModel.message}');
        }
      }
    } catch (e) {
      print('LoginController- Error_occurred: $e');
    }
  }

  String getVTokenType() {
    if (Platform.isAndroid) return "android";
    if (Platform.isIOS) return "ios";
    return "unknown";
  }

  Future<void> confirmPhoneNumber(BuildContext context) async {
    Get.toNamed(Routes.HOME);
    String? captchaToken = await NativeDataService.showCaptcha();
    print('LoginController_ Captcha_Token:::  $captchaToken');

    String rawCode = countryCodeController.value;
    String rawNumber = phoneController.text.trim();

    String code = convertDigitsArToEn(rawCode);
    String number = convertDigitsArToEn(rawNumber);

    PhoneDigitRange countryDigitRange = await getCountryPhoneDigits(code);

    if (code.isNotEmpty && number.isNotEmpty) {
      if (number.length >= countryDigitRange.min) {
        if (code == "+20" &&
            !(number.startsWith("10") ||
                number.startsWith("11") ||
                number.startsWith("12") ||
                number.startsWith("15"))) {
          showTopSnackBar(context, "Please enter a valid Egypt mobile number.");
          return;
        }

        String fullPhone = "$code$number";
        FocusScope.of(context).unfocus();

        /*  if (from == Constant.DELETE_FLOW &&
            fullPhone != Constant.getUserData().user.vPhone) {
          showTopWarningToast(context, "Another user is logged in with this phone.");
        } else {
          callSignUp(context, fullPhone);
        }*/
        //  print('LoginController_ ::: callLoginWithNumber_CALll-  ${countryCodeController.value}${phoneController.text.trim()}');
        print('LoginController_ ::: fullPhone-  ${fullPhone}');
        if(captchaToken != null)
        await callLoginWithNumber(vPhone: fullPhone, hCaptchaToken: captchaToken);

      } else {
        showTopSnackBar(context, 'Mobile number must be at least ${countryDigitRange.min} digits.');
      }
    } else if (number.isEmpty) {
      showTopWarningToast(context, "Phone number cannot be blank.");
    } else if (code.isEmpty) {
      showTopWarningToast(context, "Country code cannot be blank.");
    } else {
      showTopWarningToast(context, "Invalid country code.");
    }
  }

  String convertDigitsArToEn(String? value) {
    return _convertTextUsingMap(value, _digitsArToEn);
  }

  String _convertTextUsingMap(String? text, Map<String, String> map) {
    if (text == null || text.isEmpty) return '';

    return text.split('').map((char) => map[char] ?? char).join();
  }

  final Map<String, String> _digitsArToEn = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
  };

  onChanged({required PhoneNumber value}) {
    countryCodeController.value = value.countryCode;
    log('countryCodeController.value::  ${countryCodeController.value} ${value.number} ${value.countryISOCode}');
    phoneController.text = value.number;
    countryCode.value = value.countryISOCode;
  }
}

// Currently not using this class
/*class FeatureFlags {
  static final Map<String, dynamic> _flags = {
    "mobile.can_skip_captcha_on_login": false, // default
  };

  // Load from remote config or local source if needed
  static bool get canSkipCaptchaOnLogin => _flags["mobile.can_skip_captcha_on_login"] ?? false;

  static void setFlag(String key, dynamic value) {
    _flags[key] = value;
  }
}

class NativeLogin {
  static const MethodChannel _channel = MethodChannel('com.mrsool/native_login');

  static Future<void> callLoginWithNumber(String captchaToken) async {
    try {
      await _channel.invokeMethod('callLoginWithNumber', {'captchaToken': captchaToken});
    } on PlatformException catch (e) {
      print('Failed to call login: ${e.message}');
    }
  }
}*/
