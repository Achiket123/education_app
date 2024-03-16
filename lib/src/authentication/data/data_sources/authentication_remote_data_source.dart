import 'dart:convert';

import 'package:education_app/core/error/exceptions.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthenticationRemoteDatasource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUsers();
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  final http.Client _client;

  AuthenticationRemoteDatasourceImpl({required http.Client client})
      : _client = client;
  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client
          .post(Uri.parse("${Constants.kBaseUrl}/${Constants.usersEndpoint}"),
              body: jsonEncode(
                {
                  'createdAt': createdAt,
                  'name': name,
                },
              ),
              headers: {"content-type": "application/json"});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statuscode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statuscode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client
          .get(Uri.parse('${Constants.kBaseUrl}/${Constants.usersEndpoint}'));
      if (response.statusCode != 200) {
        throw ApiException(
            message: response.body, statuscode: response.statusCode);
      }
      return (jsonDecode(response.body) as List)
          .map((e) => UserModel.fromMap(e))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statuscode: 500);
    }
  }
}
