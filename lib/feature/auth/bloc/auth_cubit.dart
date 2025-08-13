import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_smart/app/repository/auth_repository.dart';
import 'package:sell_smart/app/repository/user_repository.dart';
import 'package:sell_smart/app/models/user_model.dart';
part 'auth_state.dart';

/// Handles authentication flows (login/signup)
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  AuthCubit({required this.authRepository, required this.userRepository})
    : super(const AuthState.initial());

  Future<void> login({required String email, required String password}) async {
    if (state is AuthLoading) return;
    emit(const AuthState.loading());

    final res = await authRepository.login(email: email, password: password);
    res.fold(
      (l) => emit(AuthState.failure(l.errorMessage)),
      (_) => emit(const AuthState.success()),
    );
  }

  Future<void> signup({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    if (state is AuthLoading) return;
    emit(const AuthState.loading());

    final res = await authRepository.signup(
      fullName: fullName,
      phone: phone,
      email: email,
      password: password,
    );
    res.fold(
      (l) => emit(AuthState.failure(l.errorMessage)),
      (userModel) async {
        // Create user in database after successful signup
        final createUserRes = await userRepository.createUser(user: userModel);
        createUserRes.fold(
          (l) => emit(AuthState.failure(l.errorMessage)),
          (_) => emit(const AuthState.success()),
        );
      },
    );
  }

  Future<void> createUser({required UserModel user}) async {
    if (state is AuthLoading) return;
    emit(const AuthState.loading());

    final res = await userRepository.createUser(user: user);
    res.fold(
      (l) => emit(AuthState.failure(l.errorMessage)),
      (_) => emit(const AuthState.success()),
    );
  }
}
