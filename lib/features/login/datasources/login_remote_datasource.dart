import 'dart:convert';

import 'package:english_app/core/result/failure.dart';
import 'package:english_app/features/login/domain/entities/params.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDatasource {
  Future<String> login(LoginParams params);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  LoginRemoteDatasourceImpl({required this.client, required this.baseUrl});
  @override
  Future<String> login(LoginParams params) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': params.username,
          'password': params.password,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)['token'];
      } else {
        throw ServerFailure('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure('Failed to login: $e');
    }
  }
}
