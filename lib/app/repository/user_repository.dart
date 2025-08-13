import 'package:dartz/dartz.dart';
import 'package:sell_smart/app/models/user_model.dart';
import 'package:sell_smart/app/service/user_service.dart';
import 'package:sell_smart/core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> createUser({required UserModel user});
  Future<Either<Failure, void>> getUser();
}

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;
  UserRepositoryImpl({required UserService userService})
    : _userService = userService;
  @override
  Future<Either<Failure, void>> createUser({required UserModel user}) async {
    return _userService.createUser(user: user);
  }

  @override
  Future<Either<Failure, void>> getUser() async {
    return _userService.getUser();
  }
}
