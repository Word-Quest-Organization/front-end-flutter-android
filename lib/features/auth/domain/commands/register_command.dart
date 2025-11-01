import 'package:english_app/core/command/command.dart';
import 'package:english_app/core/result/failure.dart';
import 'package:english_app/core/result/result.dart';
import 'package:english_app/features/auth/domain/entities/params.dart';
import 'package:english_app/features/auth/domain/entities/user_entity.dart';
import 'package:english_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterCommand implements Command<UserEntity, UserParams> {
  
  final AuthRepository repository;
  RegisterCommand({required this.repository});
  @override
  Future<Result<Failure, UserEntity>> execute(UserParams params) async{
    return await repository.register(params);
  }
}