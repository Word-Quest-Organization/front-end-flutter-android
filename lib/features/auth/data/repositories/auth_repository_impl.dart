import 'package:english_app/core/result/failure.dart';
import 'package:english_app/core/result/result.dart';
import 'package:english_app/features/auth/datasources/auth_remote_datasource.dart';
import 'package:english_app/features/auth/domain/entities/params.dart';
import 'package:english_app/features/auth/domain/entities/user_entity.dart';
import 'package:english_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Result<Failure, UserEntity>> login(UserParams params) async {
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

  @override
  Future<Result<Failure, UserEntity>> register(UserParams params) async {
    try {
      await remoteDatasource.register(params);
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
