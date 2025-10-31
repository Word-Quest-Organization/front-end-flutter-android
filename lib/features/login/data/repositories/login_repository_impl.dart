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
       
      final token = await remoteDatasource.login(params);
      
      final userModel = await remoteDatasource.getProfile(token: token);

      return Right(userModel);
    } on ServerFailure {
      return Left(ServerFailure('Email, senha ou token inválidos'));
    } catch (e) {
      return Left(ServerFailure('Erro desconhecido: $e'));
    }
  }

}