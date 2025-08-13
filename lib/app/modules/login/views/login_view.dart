import 'package:intl_phone_field/country_picker_dialog.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_exports.dart';
import '../../../utils/app_images.dart';
import '../../../localization/app_string_keys.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 60),
              Text(S.enterMobileNumber.tr, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              _buildPhoneField(),
              const Spacer(),
              _buildConfirmButton(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Top bar with back button and help icon
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Image.asset(AppImages.backWhite, width: 24, height: 24, color: const Color(0xFF58595B)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  // ✅ Navigate to Language screen
                  Get.toNamed(Routes.LANGUAGE);
                },
                child: Image.asset(
                  AppImages.icBlueSupport, // your green question mark icon
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Phone number input field with intl phone field
  Widget _buildPhoneField() {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(5),
      child: IntlPhoneField(
        controller: controller.phoneController,
        initialCountryCode: controller.countryCode.value,
        cursorColor: AppColors.primary,
        autovalidateMode: AutovalidateMode.disabled,
        dropdownIconPosition: IconPosition.trailing,
        pickerDialogStyle: PickerDialogStyle(backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          counterText: '',
          border: _outline(AppColors.primary, 1.0),
          enabledBorder: _outline(AppColors.primary, 0.8),
          focusedBorder: _outline(AppColors.primary, 0.5),
        ),
        flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 6),
        dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        onChanged: (value) => controller.onChanged(value: value),
      ),
    );
  }

  /// Outlined border styling helper
  OutlineInputBorder _outline(Color color, double width) {
    return OutlineInputBorder(borderSide: BorderSide(color: color, width: width));
  }

  /// Confirm button with reactive state
  Widget _buildConfirmButton(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: () {
              if (controller.isPhoneFilled.value) {
                controller.confirmPhoneNumber(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.isPhoneFilled.value ? AppColors.primary : AppColors.disabled,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              elevation: 0, // ✅ match flat style in screenshot
            ),
            child: Text(
              S.confirm.tr,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
