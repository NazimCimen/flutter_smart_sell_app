import 'package:flutter/foundation.dart';

@immutable
final class AppValidators {
  const AppValidators._();

  static const String emailRegExp =
      r'^[^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*|(\".+\")@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String passwordRegExp =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';
  static const String nameRegExp = r'^[a-zA-ZığüşöçİĞÜŞÖÇ ]{2,50}$';
  static const String phoneRegExp = r'^[0-9]{10,15}$';

  /// Validates name and surname input with Turkish character support.
  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'StringConstants.validationNameRequired';
    }
    if (!RegExp(nameRegExp).hasMatch(value)) {
      return 'StringConstants.validationNameInvalid';
    }
    return null;
  }

  /// Validates email address format using regex pattern.
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'StringConstants.validationEmailRequired';
    }
    if (!RegExp(emailRegExp).hasMatch(value)) {
      return 'StringConstants.validationEmailInvalid';
    }
    return null;
  }

  /// Validates password with minimum length requirement.
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'StringConstants.validationPasswordRequired';
    } else if (value.length < 6) {
      return 'StringConstants.validationPasswordMinLength';
    } else {
      return null;
    }
  }

  /// Validates phone number with basic numeric length constraints.
  static String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'StringConstants.validationPhoneRequired';
    }
    if (!RegExp(phoneRegExp).hasMatch(value)) {
      return 'StringConstants.validationPhoneInvalid';
    }
    return null;
  }

}
