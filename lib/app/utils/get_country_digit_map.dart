import 'dart:convert';
import 'package:flutter/services.dart'; // Required for rootBundle

/// Represents the minimum and maximum digit length for a phone number in a specific country.
class PhoneDigitRange {
  final int min;
  final int max;

  /// Creates a [PhoneDigitRange] instance.
  PhoneDigitRange({required this.min, required this.max});

  /// Factory constructor to create a [PhoneDigitRange] from a JSON map.
  /// Used for deserialization from the configuration file.
  factory PhoneDigitRange.fromJson(Map<String, dynamic> json) {
    return PhoneDigitRange(
      min: json['min'] as int,
      max: json['max'] as int,
    );
  }

  /// Converts this [PhoneDigitRange] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
    };
  }
}

/// Represents the overall phone validation configuration, containing a map
/// of country codes to their respective phone digit ranges.
class PhoneValidationConfig {
  final Map<String, PhoneDigitRange> countryDigitMap;

  /// Creates a [PhoneValidationConfig] instance.
  PhoneValidationConfig({required this.countryDigitMap});

  /// Factory constructor to create a [PhoneValidationConfig] from a JSON map.
  /// Used for deserialization from the configuration file.
  factory PhoneValidationConfig.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> map = json['countryDigitMap'] as Map<String, dynamic>;
    final Map<String, PhoneDigitRange> parsedMap = map.map(
          (key, value) => MapEntry(key, PhoneDigitRange.fromJson(value as Map<String, dynamic>)),
    );
    return PhoneValidationConfig(countryDigitMap: parsedMap);
  }

  /// Converts this [PhoneValidationConfig] instance to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = countryDigitMap.map(
          (key, value) => MapEntry(key, value.toJson()),
    );
    return {
      'countryDigitMap': map,
    };
  }
}

// Mock FeatureFlags for demonstration.
// In a real application, this would be replaced by your actual feature flag
// implementation (e.g., from Firebase Remote Config, a dedicated service, etc.).
class FeatureFlags {
  // This string would typically come from a remote configuration service.
  // For now, it's an empty string, meaning the app will fall back to the local asset.
  static String phoneValidationConfigString = ''; // Example: '{"countryDigitMap":{"US":{"min":10,"max":10}}}'

// You might have a method here to fetch the latest config
// static Future<void> fetchRemoteConfig() async {
//   // Logic to fetch remote config and update phoneValidationConfigString
// }
}

/// Asynchronously retrieves the country phone digit map.
///
/// It first attempts to get the configuration from `FeatureFlags`.
/// If the feature flag is empty, it falls back to reading from the
/// `assets/json/phone_validation_config.json` file.
/// If both sources are empty or fail to parse, it returns an empty map.
Future<Map<String, PhoneDigitRange>> getCountryDigitMap() async {
  // Attempt to get the configuration from the FeatureFlags (e.g., remote config)
  String configString = FeatureFlags.phoneValidationConfigString;

  // If the feature flag configuration is empty, try to read from the local raw asset file.
  if (configString.isEmpty) {
    try {
      // Ensure 'assets/json/phone_validation_config.json' is declared in your pubspec.yaml
      // under the 'assets:' section.
      configString = await rootBundle.loadString('assets/json/phone_validation_config.json');
    } catch (e) {
      // Log the error if the asset file cannot be found or read.
      // In a production app, you might want to use a proper logging framework.
      print('Error reading assets/json/phone_validation_config.json: $e');
      // Fallback to an empty JSON structure to prevent parsing errors later.
      configString = "{\"countryDigitMap\":{}}";
    }
  }

  // Final fallback to an empty JSON structure if configString is still empty
  // after checking both feature flags and local assets.
  if (configString.isEmpty) {
    configString = "{\"countryDigitMap\":{}}";
  }

  try {
    // Decode the JSON string into a Dart Map<String, dynamic>.
    final Map<String, dynamic> jsonMap = jsonDecode(configString);
    // Create a PhoneValidationConfig object from the JSON map and return its countryDigitMap.
    return PhoneValidationConfig.fromJson(jsonMap).countryDigitMap;
  } catch (e) {
    // Log any errors that occur during JSON parsing.
    print('Error parsing phone validation config JSON: $e');
    // Return an empty map if parsing fails.
    return {};
  }
}
