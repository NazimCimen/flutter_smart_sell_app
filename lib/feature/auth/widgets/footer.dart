import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;
  const Footer({
    required this.text,
    required this.linkText,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
        children: [
          TextSpan(
            text: linkText,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTap();
              },
          ),
        ],
      ),
    );
  }
}
