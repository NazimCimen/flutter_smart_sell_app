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
import 'package:sell_smart/feature/auth/mixin/signup_mixin.dart';
import 'package:sell_smart/feature/auth/widgets/auth_with_other_provider.dart';
import 'package:sell_smart/feature/auth/widgets/footer.dart';
import 'package:sell_smart/feature/auth/widgets/header.dart';
import 'package:sell_smart/feature/auth/widgets/custom_password_text_field.dart';
import 'package:sell_smart/feature/auth/widgets/custom_text_form_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> with SignupMixin {
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
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Signup title
                              const Header(
                                title: 'Merhaba',
                                subtitle: 'SmartSelle Hoşgeldiniz',
                              ),
                              SizedBox(height: context.cXLargeValue * 1.5),

                              // Full Name input field
                              CustomTextFormField(
                                controller: fullNameController,
                                validator: (value) =>
                                    AppValidators.nameValidator(value),
                                hintText: 'İsim Soyisim',
                                prefixIconPath:
                                    ImageEnums.ic_nameSurname.toPathPng,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: context.cMediumValue),

                              // Phone Number input field
                              CustomTextFormField(
                                controller: phoneController,
                                validator: (value) =>
                                    AppValidators.phoneValidator(value),
                                hintText: 'Telefon Numarası',
                                prefixIconPath:
                                    ImageEnums.ic_nameSurname.toPathPng,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: context.cMediumValue),

                              // Email input field
                              CustomTextFormField(
                                controller: emailController,
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
                                controller: passwordController,
                                hintText: 'Şifre',
                                obsecureText: obscure,
                                changeObsecureText: () =>
                                    setState(() => obscure = !obscure),
                              ),

                              SizedBox(height: context.cMediumValue),
                              
                              // Signup button
                              CustomButtonWidget(
                                onPressed: validateForm,
                                text: 'Kayıt Ol',
                                isRequestAvaliable: state is AuthLoading,
                              ),

                              SizedBox(height: context.cXLargeValue * 1.5),

                              // Social media login buttons
                              AuthWithOtherProvider(
                                onGoogleTap: onTapGoogle,
                                onAppleTap: onTapApple,
                                onFacebookTap: onTapFacebook,
                              ),

                              SizedBox(height: context.cXLargeValue * 1.5),

                              // Sign up link
                              Footer(
                                text: 'Hesabınız var mı? ',
                                linkText: 'Giriş Yap',
                                onTap: () {
                                  context.go(AppRoutes.login);
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
