import 'package:english_app/core/result/result.dart';
import 'package:english_app/features/auth/domain/commands/login_command.dart';
import 'package:english_app/features/auth/domain/commands/register_command.dart';
import 'package:english_app/features/auth/domain/entities/params.dart';
import 'package:english_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier{
  final LoginCommand loginCommand;
  final RegisterCommand registerCommand;
  AuthViewModel({required this.loginCommand, required this.registerCommand});

  // Inicio do estado
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserEntity? _user;
  UserEntity? get user => _user;
  // Fim do estado

  Future<void> doLogin(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _user = null;
    notifyListeners();

    final params = UserParams(username: username, email: username, password: password);
    final result = await loginCommand.execute(params);

  // Atualiza o estado com base no resultado
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
      },
      (userEntity) {
        _user = userEntity;
        _isLoading = false;
      },
    );

    notifyListeners();
  }

  Future<void> doRegister(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _user = null;
    notifyListeners();

    final params = UserParams(username: name, email: email, password: password);
    final result = await registerCommand.execute(params);

  // Atualiza o estado com base no resultado
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
      },
      (userEntity) {
        _user = userEntity;
        _isLoading = false;
      },
    );

    notifyListeners();
  }
}