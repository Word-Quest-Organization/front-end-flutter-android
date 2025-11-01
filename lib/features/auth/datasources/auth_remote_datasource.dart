import 'dart:convert';
import 'dart:developer';

import 'package:english_app/core/result/failure.dart';
import 'package:english_app/features/auth/data/models/user_model.dart';
import 'package:english_app/features/auth/domain/entities/params.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDatasource {
  Future<String> login(UserParams params);
  Future<void> register(UserParams params);
  Future<UserModel> getProfile({required String token});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  AuthRemoteDatasourceImpl({required this.client, required this.baseUrl});
  @override
  Future<String> login(UserParams params) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': params.email, 'password': params.password}),
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
  Future<void> register(UserParams params) async {
    final url = Uri.parse('$baseUrl/auth/register');

    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': params.username,
          'email': params.email,
          'password': params.password,
        }),
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw ServerFailure('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure('Failed to register: $e');
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
