import 'package:get/get.dart';
import 'app_string_keys.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // English (US)
    'en_US': {
      S.enterMobileNumber: 'Enter your mobile number',
      S.confirm: 'Confirm',
      S.language: 'Language',
      S.english: 'English',
      S.arabic: 'Arabic (Saudi)',
      S.chooseLanguage: 'Choose your language',
    },
    // Arabic (Saudi Arabia) — RTL
    'ar_SA': {
      S.enterMobileNumber: 'أدخل رقم جوالك',
      S.confirm: 'تأكيد',
      S.language: 'اللغة',
      S.english: 'الإنجليزية',
      S.arabic: 'العربية (السعودية)',
      S.chooseLanguage: 'اختر لغتك',
    },
  };
}
