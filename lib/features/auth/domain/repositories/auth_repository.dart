import 'package:english_app/core/result/failure.dart';
import 'package:english_app/core/result/result.dart';
import 'package:english_app/features/auth/domain/entities/params.dart';
import 'package:english_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<Failure, UserEntity>> login(UserParams params);
  Future<Result<Failure, UserEntity>> register(UserParams params);
}
