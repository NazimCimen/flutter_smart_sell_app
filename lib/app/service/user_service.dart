import 'package:dartz/dartz.dart';
import 'package:sell_smart/app/models/user_model.dart';
import 'package:sell_smart/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserService {
  Future<Either<Failure, void>> createUser({required UserModel user});
  Future<Either<Failure, void>> getUser();
}

class UserServiceImpl implements UserService {
  final SupabaseClient _supabase;
  UserServiceImpl() : _supabase = Supabase.instance.client;
  @override
  Future<Either<Failure, void>> getUser() async {
    return right(null);
  }

  @override
  Future<Either<Failure, void>> createUser({required UserModel user}) async {
    try {
      final response = await _supabase
          .from('users')
          .insert(user.toJson())
          .select();
      if (response.isNotEmpty) return right(null);
      return left(ServerFailure(errorMessage: 'User creation failed'));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
