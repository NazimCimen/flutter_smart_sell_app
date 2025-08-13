import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_smart/app/common/widgets/custom_button.dart';
import 'package:sell_smart/app/config/routes/app_routes.dart';
import 'package:sell_smart/app/repository/user_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:sell_smart/app/config/localization/string_constants.dart';
import 'package:sell_smart/core/utils/app_validators.dart';
import 'package:sell_smart/core/utils/enum/image_enum.dart';
import 'package:sell_smart/core/utils/size/constant_size.dart';
import 'package:sell_smart/feature/auth/bloc/auth_cubit.dart';
import 'package:sell_smart/feature/auth/mixin/login_mixin.dart';
import 'package:sell_smart/feature/auth/widgets/auth_with_other_provider.dart';
import 'package:sell_smart/feature/auth/widgets/footer.dart';
import 'package:sell_smart/feature/auth/widgets/header.dart';
import 'package:sell_smart/feature/auth/widgets/custom_password_text_field.dart';
import 'package:sell_smart/feature/auth/widgets/custom_text_form_field.dart';
import 'package:sell_smart/core/init/di_container.dart';
import 'package:sell_smart/app/repository/auth_repository.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        authRepository: getIt<AuthRepository>(),
        userRepository: getIt<UserRepository>(),
      ),
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
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Login title
                              Header(
                                title: StringConstants.authLoginTitle,
                                subtitle: StringConstants.authLoginSubtitle,
                              ),
                              SizedBox(
                                height: context.cXLargeValue * 1.5,
                              ), // Email input field
                              CustomTextFormField(
                                controller: emailController,
                                validator: (value) =>
                                    AppValidators.emailValidator(value),
                                hintText: StringConstants.email,
                                prefixIconPath: ImageEnums.ic_email.toPathPng,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: context.cMediumValue),

                              // Password input field
                              ValueListenableBuilder<bool>(
                                valueListenable: obscureListenable,
                                builder: (context, isObscure, _) {
                                  return CustomPasswordTextField(
                                    controller: passwordController,
                                    hintText: StringConstants.password,
                                    obsecureText: isObscure,
                                    changeObsecureText: changeObsecureText,
                                  );
                                },
                              ),

                              SizedBox(height: context.cMediumValue),
                              // Login button
                              CustomButtonWidget(
                                onPressed: () => login(context),
                                text: StringConstants.login,
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
                                text: StringConstants.dontHaveAccount,
                                linkText: StringConstants.goToSignup,
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
