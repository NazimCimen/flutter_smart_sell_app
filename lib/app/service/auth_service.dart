import 'package:dartz/dartz.dart';
import 'package:sell_smart/core/error/failure.dart';
import 'package:sell_smart/app/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Abstract authentication service
abstract class AuthService {
  Future<Either<Failure, UserModel>> signup({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  });

  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();
}

/// Supabase-backed implementation
final class SupabaseAuthService implements AuthService {
  SupabaseAuthService() : _supabase = Supabase.instance.client;
  final SupabaseClient _supabase;

  @override
  Future<Either<Failure, UserModel>> signup({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        final userModel = UserModel(
          id: int.parse(response.user!.id),
          fullName: fullName,
          phoneNumber: phone,
          emailAddress: email,
          createdAt: DateTime.now(),
        );
        return right(userModel);
      }
      return left(ServerFailure(errorMessage: 'sign up failed'));
    } on AuthException catch (e) {
      return left(ServerFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) return right(null);
      return left(ServerFailure(errorMessage: 'login failed'));
    } on AuthException catch (e) {
      return left(ServerFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _supabase.auth.signOut();
      return right(null);
    } on AuthException catch (e) {
      return left(ServerFailure(errorMessage: e.message));
    }
  }
}
