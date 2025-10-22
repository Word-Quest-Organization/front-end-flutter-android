import 'package:english_app/core/result/failure.dart';
import 'package:english_app/core/result/result.dart';
import 'package:english_app/features/login/domain/entities/params.dart';
import 'package:english_app/features/login/domain/entities/user_entity.dart';

abstract class LoginRepository {
  Future<Result<Failure, UserEntity>> login(LoginParams params);
}
