import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../localization/app_string_keys.dart';
import '../../../localization/locales.dart';
import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.primary, // green header area
      body: SafeArea(
        child: Column(
          children: [
            // Header + center logo/icon (big green area)
            Expanded(
              child: Center(
                child: _logoOrIcon(),
              ),
            ),

            // Bottom sheet UI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Obx(() {
                final current = controller.currentLocale.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: controller.currentLocale.value == AppLocales.enUS ? 16 : 13,
                    ),
                    Text(
                      S.chooseLanguage.tr, // "Choose your language"
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // English tile
                    _langTile(
                      title: S.english.tr,
                      selected: current == AppLocales.enUS,
                      onTap: () => controller.changeLanguage(AppLocales.enUS),
                    ),
                    const SizedBox(height: 12),

                    // Arabic tile
                    _langTile(
                      title: S.arabic.tr,
                      selected: current == AppLocales.arSA,
                      onTap: () => controller.changeLanguage(AppLocales.arSA),
                    ),
                    const SizedBox(height: 20),

                    // Confirm button (just closes the screen; language already applied)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          S.confirm.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // If you have a logo asset, swap this with Image.asset('path')
  Widget _logoOrIcon() {
    // return Image.asset(AppImages.logo, width: 96, height: 96); // if you have one
    return const Icon(Icons.hub, size: 96, color: Colors.black87);
  }

  Widget _langTile({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        decoration: BoxDecoration(
          color: selected ? Colors.amber : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? Colors.amber : const Color(0xFFD9D9D9),
            width: 1.2,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color: Colors.amber.withValues(alpha: 0.25),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ]
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  color: selected ? Colors.black : const Color(0xFF8E8E93),
                  fontSize: 16,
                ),
              ),
            ),
            if (selected)
              const Icon(Icons.check_rounded, color: Colors.black, size: 22),
          ],
        ),
      ),
    );
  }
}
