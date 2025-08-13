import 'package:flutter/material.dart';
import 'package:sell_smart/app/config/theme/app_colors.dart';
import 'package:sell_smart/core/utils/size/app_border_radius_extensions.dart';

class CustomInputDecoration {
  CustomInputDecoration._();
  static InputDecoration inputAuthDecoration({
    required BuildContext context,
    required String hintText,
    required String prefixIconPath,
    bool? isPassword,
    VoidCallback? changeObsecureText,
    bool? obsecureText,
  }) => InputDecoration(
    // Use surface color for a clean, card-like input background
    fillColor: Theme.of(context).colorScheme.surface,
    filled: true,
    prefixIcon: Image.asset(
      prefixIconPath,
      // Softer icon color that harmonizes with outlines
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.7),
    ),
    hintText: hintText,
    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.8),
      fontSize: 14,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
    ),
    suffixIcon: isPassword ?? false
        ? IconButton(
            onPressed: changeObsecureText ?? () {},
            icon: Icon(
              obsecureText ?? false ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.8),
            ),
          )
        : const SizedBox.shrink(),
  );
}
