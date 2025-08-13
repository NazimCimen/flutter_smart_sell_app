import 'package:flutter/foundation.dart';

/// Abstraction for authentication data operations.
@immutable
abstract class AuthRepository {
  Future<void> login({required String email, required String password});

  Future<void> signup({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  });
}

/// Temporary in-memory implementation to keep the app functional.
/// Replace this with your real service-backed implementation.
final class DummyAuthRepository implements AuthRepository {
  @override
  Future<void> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final bool ok = email.isNotEmpty && password.length >= 6;
    if (!ok) throw Exception('Email veya şifre geçersiz.');
  }

  @override
  Future<void> signup({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    final bool ok =
        fullName.trim().length >= 2 && phone.trim().length >= 10 && email.isNotEmpty && password.length >= 6;
    if (!ok) throw Exception('Kayıt bilgileri geçersiz.');
  }
}


