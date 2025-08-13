import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_smart/feature/auth/bloc/auth_cubit.dart';
import 'package:sell_smart/feature/auth/view/signup_view.dart';

mixin SignupMixin on State<SignupView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool obscure = true;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSignupButtonPressed() async {
    await context.read<AuthCubit>().signup(
      fullName: fullNameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  Future<void> validateForm() async {
    if (formKey.currentState?.validate() ?? false) {
      await _onSignupButtonPressed();
    }
  }

  Future<void> onTapGoogle() async {}

  Future<void> onTapApple() async {}

  Future<void> onTapFacebook() async {}
}
