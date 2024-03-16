import 'dart:convert';

import 'package:education_app/core/error/exceptions.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;

  late AuthenticationRemoteDatasource authenticationRemoteDatasource;

  setUp(() {
    client = MockClient();
    authenticationRemoteDatasource =
        AuthenticationRemoteDatasourceImpl(client: client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when status code is 200 or 201 ',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (invocation) async =>
              http.Response('user created successfully', 201));

      final methodcall = authenticationRemoteDatasource.createUser;
      expect(methodcall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          completes);

      verify(
        () => client.post(
            Uri.parse('${Constants.kBaseUrl}/${Constants.usersEndpoint}'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              "avatar": 'avatar'
            })),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should through an API exception when status code is not 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (invocation) async => http.Response('Invalid Response', 500));

      final meethodCall = authenticationRemoteDatasource.createUser;
      expect(
          meethodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          throwsA(const ApiException(
              message: 'Invalid Response', statuscode: 500)));

      verify(
        () => client.post(
            Uri.parse('${Constants.kBaseUrl}/${Constants.usersEndpoint}'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              "avatar": 'avatar'
            })),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getUser', () {
    const tUsers = [UserModel.empty()];
    test('should return [List<Users>] when status code is 200', () async {
      when(
        () => client.get(any()),
      ).thenAnswer((invocation) async => http.Response(
          jsonEncode(
            [tUsers.first.toMap()],
          ),
          200));

      final result = await authenticationRemoteDatasource.getUsers();
      expect(result, equals(tUsers));

      verify(
        () => client
            .get(Uri.parse('${Constants.kBaseUrl}/${Constants.usersEndpoint}')),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw API exception when there is an error', () async {
      const tMessage = 'Server Down';
      const tstatusCode = 500;
      when(
        () => client
            .get(Uri.parse('${Constants.kBaseUrl}/${Constants.usersEndpoint}')),
      ).thenAnswer((invocation) async => http.Response(tMessage,tstatusCode));
      final methodCall = authenticationRemoteDatasource.getUsers;
      expect(() => methodCall(),
          throwsA(const ApiException(message: tMessage, statuscode: tstatusCode)));
    });

     verify(
        () => client
            .get(Uri.parse('${Constants.kBaseUrl}/${Constants.usersEndpoint}')),
      ).called(1);
      verifyNoMoreInteractions(client);
  });
}
