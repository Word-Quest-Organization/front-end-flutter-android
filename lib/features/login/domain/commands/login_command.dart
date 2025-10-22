import 'package:english_app/core/command/command.dart';
import 'package:english_app/core/result/failure.dart';
import 'package:english_app/core/result/result.dart';
import 'package:english_app/features/login/domain/entities/params.dart';
import 'package:english_app/features/login/domain/entities/user_entity.dart';
import 'package:english_app/features/login/domain/repositories/login_repository.dart';

class LoginCommand implements Command<UserEntity, LoginParams> {
  
  final LoginRepository repository;
  LoginCommand({required this.repository});
  @override
  Future<Result<Failure, UserEntity>> execute(LoginParams params) async{
    return await repository.login(params);
  }
}