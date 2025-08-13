import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:sell_smart/app/service/auth_service.dart';
import 'package:sell_smart/core/error/failure.dart';
import 'package:sell_smart/app/models/user_model.dart';

/// Abstraction for authentication data operations.
@immutable
abstract class AuthRepository {
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> signup({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  });
}

/// Repository implementation that delegates to injected AuthService
final class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;
  AuthRepositoryImpl({required AuthService service}) : _service = service;

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    return _service.login(email: email, password: password);
  }

  @override
  Future<Either<Failure, UserModel>> signup({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    return _service.signup(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
    );
  }
}
