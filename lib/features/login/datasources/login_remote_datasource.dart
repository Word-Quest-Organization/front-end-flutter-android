import 'dart:convert';
import 'dart:developer';

import 'package:english_app/core/result/failure.dart';
import 'package:english_app/features/login/data/models/user_model.dart';
import 'package:english_app/features/login/domain/entities/params.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDatasource {
  Future<String> login(LoginParams params);
  Future<UserModel> getProfile({required String token});
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
          'email': params.username,
          'password': params.password,
        }),
      );
      inspect(response);
      if (response.statusCode == 200) {
        return json.decode(response.body)['token'];
      } else {
        throw ServerFailure('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure('Failed to login: $e');
    }
  }

  @override
  Future<UserModel> getProfile({required String token}) async {
    final url = Uri.parse('$baseUrl/user/profile');

    try {
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(json.decode(response.body));
      } else {
        throw ServerFailure('Failed to fetch profile: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure('Failed to fetch profile: $e');
    }
  }
}
