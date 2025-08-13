import 'package:get_it/get_it.dart';
import 'package:sell_smart/app/repository/auth_repository.dart';
import 'package:sell_smart/app/repository/user_repository.dart';
import 'package:sell_smart/app/service/auth_service.dart';
import 'package:sell_smart/app/service/user_service.dart';

final getIt = GetIt.instance;
void setupDI() {
  getIt
    ..registerLazySingleton<AuthService>(() => SupabaseAuthService())
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(service: getIt<AuthService>()),
    )
    ..registerLazySingleton<UserService>(() => UserServiceImpl())
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userService: getIt<UserService>()),
    );
}
