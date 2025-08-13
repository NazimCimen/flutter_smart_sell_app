import 'package:sell_smart/app/common/decorations/input_decorations/custom_input_decoration.dart';
import 'package:sell_smart/core/utils/app_validators.dart';
import 'package:sell_smart/core/utils/enum/image_enum.dart';
import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obsecureText;
  final VoidCallback? changeObsecureText;
  final String? hintText;
  const CustomPasswordTextField({
    required this.controller,
    required this.obsecureText,
    this.changeObsecureText,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => AppValidators.passwordValidator(value),
      obscureText: obsecureText,
      textInputAction: TextInputAction.done,
      decoration: CustomInputDecoration.inputAuthDecoration(
        context: context,
        hintText: hintText ?? 'Şifre',
        prefixIconPath: ImageEnums.ic_password.toPathPng,
        isPassword: changeObsecureText != null,
        changeObsecureText: changeObsecureText,
        obsecureText: obsecureText,
      ),
    );
  }
}
