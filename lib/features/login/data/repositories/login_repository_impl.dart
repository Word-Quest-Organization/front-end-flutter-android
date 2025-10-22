import 'package:english_app/core/result/failure.dart';
import 'package:english_app/core/result/result.dart';
import 'package:english_app/features/login/datasources/login_remote_datasource.dart';
import 'package:english_app/features/login/domain/entities/params.dart';
import 'package:english_app/features/login/domain/entities/user_entity.dart';
import 'package:english_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDatasource remoteDatasource;

  LoginRepositoryImpl({required this.remoteDatasource});
  
  @override
  Future<Result<Failure, UserEntity>> login(LoginParams params) async{

    try {
      final userModel = await remoteDatasource.login(params);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}