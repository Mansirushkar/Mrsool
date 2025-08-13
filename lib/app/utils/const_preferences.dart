import 'package:shared_preferences/shared_preferences.dart';

class ConstPreferences {
  // ── Existing keys ─────────────────────────────────────────────
  static const String INTRO = "INTRO";
  static const String LOGINVERIFY = "LOGINVERIFY";
  static const String REGISTERVERIFY = "REGISTERVERIFY";
  static const String ACCESSTOKEN = "ACCESSTOKEN";
  static const String ACCOUNTTYPE = "ACCOUNTTYPE";
  static const String THEME = "THEME";

  // ── New: Locale key (for GetX localization) ───────────────────
  static const String APP_LOCALE_CODE = 'app_locale_code'; // e.g., 'en_US', 'ar_SA'

  // ── Existing specific methods (unchanged) ─────────────────────
  static Future<void> setAccountType(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCOUNTTYPE, value);
  }

  static Future<String?> getAccountType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ACCOUNTTYPE);
  }

  static Future<void> setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME, value);
  }

  static Future<bool?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME);
  }

  static Future<void> setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESSTOKEN, value);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ACCESSTOKEN);
  }

  static Future<void> setRegisterVerify(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(REGISTERVERIFY, value);
  }

  static Future<bool?> getRegisterVerify() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(REGISTERVERIFY);
  }

  static Future<void> setLoginVerify(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(LOGINVERIFY, value);
  }

  static Future<bool?> getLoginVerify() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(LOGINVERIFY);
  }

  static Future<void> setIntroDone(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(INTRO, value);
  }

  static Future<bool?> getIntroDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(INTRO);
  }

  static Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> removePreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> removePreferencesAll(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // ── New: Locale-specific helpers (simple to use in controllers) ─
  static Future<void> setAppLocaleCode(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(APP_LOCALE_CODE, value);
  }

  static Future<String?> getAppLocaleCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(APP_LOCALE_CODE);
  }

  // ── New: Generic helpers for future keys ───────────────────────
  static Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> setBoolGeneric(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBoolGeneric(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<void> setDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }
}
