
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_smart/app/common/widgets/custom_button.dart';
import 'package:sell_smart/app/config/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:sell_smart/core/utils/app_validators.dart';
import 'package:sell_smart/core/utils/enum/image_enum.dart';
import 'package:sell_smart/core/utils/size/constant_size.dart';
import 'package:sell_smart/feature/auth/bloc/auth_cubit.dart';
import 'package:sell_smart/app/repository/auth_repository.dart';
import 'package:sell_smart/feature/auth/widgets/auth_with_other_provider.dart';
import 'package:sell_smart/feature/auth/widgets/footer.dart';
import 'package:sell_smart/feature/auth/widgets/header.dart';
import 'package:sell_smart/feature/auth/widgets/custom_password_text_field.dart';
import 'package:sell_smart/feature/auth/widgets/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(authRepository: DummyAuthRepository()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Giriş başarılı')));
            context.go(AppRoutes.login);
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AuthLoading,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: context.cXLargeValue,
                        right: context.cXLargeValue,
                        top: context.cMediumValue,
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom +
                            context.cMediumValue,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Login title
                              const Header(
                                title: 'Merhaba',
                                subtitle: 'SmartSelle Hoşgeldiniz',
                              ),
                              SizedBox(
                                height: context.cXLargeValue * 1.5,
                              ), // Email input field
                              CustomTextFormField(
                                controller: _emailController,
                                validator: (value) =>
                                    AppValidators.emailValidator(value),
                                hintText: 'Email',
                                prefixIconPath: ImageEnums.ic_email.toPathPng,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: context.cMediumValue),

                              // Password input field
                              CustomPasswordTextField(
                                controller: _passwordController,
                                obsecureText: _obscure,
                                changeObsecureText: () =>
                                    setState(() => _obscure = !_obscure),
                              ),

                              SizedBox(height: context.cMediumValue),
                              // Login button
                              CustomButtonWidget(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    await context.read<AuthCubit>().login(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                    );
                                  }
                                },
                                text: 'Giriş Yap',
                                isRequestAvaliable: state is AuthLoading,
                              ),

                              SizedBox(height: context.cXLargeValue * 1.5),

                              // Social media login buttons
                              AuthWithOtherProvider(
                                onGoogleTap: () async {
                                  // Google Sign In implementation
                                },
                                onAppleTap: () {
                                  // Apple Sign In implementation
                                },
                                onFacebookTap: () {
                                  // Facebook Sign In implementation
                                },
                              ),

                              SizedBox(height: context.cXLargeValue * 1.5),

                              // Sign up link
                              Footer(
                                text: 'Hesabınız yok mu? ',
                                linkText: 'Kayıt Ol',
                                onTap: () {
                                  context.go(AppRoutes.signup);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

