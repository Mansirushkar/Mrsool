// lib/services/captcha_service.dart (or your preferred location)
import 'dart:ffi';

import 'package:flutter/services.dart';

class NativeDataService {
  // Renamed for more general use
  // Must match the channel name in MainActivity.java
  static const MethodChannel _channel = MethodChannel('com.mrsool');

  static Future<String?> getDeviceToken() async {
    try {
      return await _channel.invokeMethod<String>('getDeviceToken');
    } on PlatformException catch (e) {
      print("Error getting device token: ${e.message}");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getDeviceInfo() async {
    try {
      final result = await _channel.invokeMethod('getDeviceInfo');
      return Map<String, dynamic>.from(result ?? {});
    } on PlatformException catch (e) {
      print("Error getting device info: ${e.message}");
      return null;
    }
  }


  static void setNativeListener(Function(String) onTokenReceived) {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'receiveHCaptchaToken':
          String token = call.arguments;
          print("Token from native: $token");
          onTokenReceived(token);
          break;
        default:
          print("Unknown method ${call.method}");
      }
    });
  }

  static Future<void> openOTPActivity(String phone, String countryCode,
      String display_val_cc_phone, int userId) async {
    try {
      await _channel.invokeMethod('openOTPActivity', {'phone': phone,
        'countryCode':countryCode, 'display_val_cc_phone':display_val_cc_phone, 'user_id':userId });
    } on PlatformException catch (e) {
      print("Failed to open OTP activity: '${e.message}'.");
    }
  }

  // Hcaptcha invoke function not called for now
  static Future<String?> showCaptcha() async {
    try {
      final result = await _channel.invokeMethod<String>('showCaptcha');

      if (result != null) {
        print("LoginController- Captcha token: $result");
      } else {
        print("LoginController- Captcha cancelled or failed");
      }
      return result;
    } on PlatformException catch (e) {
      print('LoginController- Captcha failed: ${e.message}');
      return null;
    }
  }


}

  // Optional: If Flutter needs to request something from native
  // static Future<String?> getDataFromNative(String key) async {
  //   try {
  //     final String? result = await _platform.invokeMethod('getNativeData', {'key': key});
  //     return result;
  //   } on PlatformException catch (e) {
  //     print("Failed to get data from native: '${e.message}'.");
  //     return null;
  //   }
  // }
//}

// In your main.dart or app initialization:
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NativeDataService.initialize(); // Initialize before running the app
//   runApp(MyApp());
// }
