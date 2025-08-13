import 'package:flutter/material.dart';
import 'package:sell_smart/core/utils/enum/image_enum.dart';
import 'package:sell_smart/core/utils/size/app_border_radius_extensions.dart';
import 'package:sell_smart/core/utils/size/constant_size.dart';

class AuthWithOtherProvider extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;
  final VoidCallback? onFacebookTap;

  const AuthWithOtherProvider({
    this.isLoading = false,
    this.onGoogleTap,
    this.onAppleTap,
    this.onFacebookTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ProviderButton(
          icon: ImageEnums.ic_google.toPathPng,
          onTap: onGoogleTap,
        ),
        SizedBox(width: context.cLowValue),
        _ProviderButton(icon: ImageEnums.ic_apple.toPathPng, onTap: onAppleTap),
        SizedBox(width: context.cLowValue),
        _ProviderButton(
          icon: ImageEnums.ic_facebook.toPathPng,
          onTap: onFacebookTap,
        ),
      ],
    );
  }
}

class _ProviderButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  const _ProviderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.cXLargeValue*1.8,
        width: context.cXLargeValue*1.8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: context.cBorderRadiusAllMedium,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: context.cLowValue,
              offset: Offset(0, context.cLowValue/4),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            icon,
            fit: BoxFit.contain,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }
}
