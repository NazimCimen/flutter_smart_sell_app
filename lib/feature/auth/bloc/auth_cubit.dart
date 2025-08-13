import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_smart/app/repository/auth_repository.dart';

part 'auth_state.dart';

/// Handles authentication flows (login/signup)
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(const AuthState.initial());

  Future<void> login({required String email, required String password}) async {
    if (state is AuthLoading) return;
    emit(const AuthState.loading());
    try {
      await authRepository.login(email: email, password: password);
      emit(const AuthState.success());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> signup({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    if (state is AuthLoading) return;
    emit(const AuthState.loading());
    try {
      await authRepository.signup(
        fullName: fullName,
        phone: phone,
        email: email,
        password: password,
      );
      emit(const AuthState.success());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  void logout() {
    emit(const AuthState.initial());
  }
}
