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
  late final ValueNotifier<bool> _obscureVN;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  ValueNotifier<bool> get obscureListenable => _obscureVN;
  bool get obscure => _obscureVN.value;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureVN = ValueNotifier<bool>(true);
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _obscureVN.dispose();
    super.dispose();
  }

  Future<void> signUp(BuildContext context) async {
    if (_validateForm()) {
      await context.read<AuthCubit>().signup(
        fullName: fullNameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    }
  }

  bool _validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> onTapGoogle() async {}

  Future<void> onTapApple() async {}

  Future<void> onTapFacebook() async {}

  void changeObsecureText() {
    _obscureVN.value = !_obscureVN.value;
  }
}
