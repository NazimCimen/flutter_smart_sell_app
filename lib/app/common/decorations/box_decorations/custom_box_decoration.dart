import 'package:sell_smart/core/utils/size/constant_size.dart';
import 'package:sell_smart/app/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sell_smart/core/utils/size/app_border_radius_extensions.dart';

class CustomBoxDecoration {
  CustomBoxDecoration._();
  static BoxDecoration customBoxDecorationForImage(BuildContext context) {
    return BoxDecoration(
      borderRadius: context.borderRadiusAllLow,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      border: Border.all(
        color: Theme.of(context).colorScheme.tertiary,
        width: 2,
      ),
    );
  }

  static BoxDecoration customBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: context.borderRadiusAllLow,
    );
  }

  static BoxDecoration customBoxDecorationTopRadius(BuildContext context) {
    return BoxDecoration(
      //  color: AppColors.background,
      border: const Border(top: BorderSide(color: AppColors.grey)),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(context.cMediumValue),
        topRight: Radius.circular(context.cMediumValue),
      ),
    );
  }

  static BoxDecoration customWordCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: context.borderRadiusAllMedium,
      border: Border.all(
        color: Theme.of(context).colorScheme.outline.withValues(alpha:0.1),
        width: context.cLowValue / 8,
      ),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha:0.03),
          blurRadius: context.cLowValue,
          offset: Offset(0, context.cLowValue / 4),
        ),
      ],
    );
  }
}
