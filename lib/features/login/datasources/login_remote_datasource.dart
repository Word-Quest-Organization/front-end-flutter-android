import 'package:english_app/core/result/failure.dart';
import 'package:english_app/features/login/data/models/user_model.dart';
import 'package:english_app/features/login/domain/entities/params.dart';

abstract class LoginRemoteDatasource {
  Future<UserModel> login(LoginParams params);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  @override
  Future<UserModel> login(LoginParams params) async {
    // Simulate a network call with a delay
    await Future.delayed(Duration(seconds: 1));
    if (params.username == 'teste@teste.com') {
      // Simula um JSON de resposta
      final fakeJson = {'id': '1', 'name': 'Usuário Teste', 'email': params.username};
      return UserModel.fromJson(fakeJson);
    } else {
      throw ServerFailure("E-mail ou senha inválidos");
    }
  }
}