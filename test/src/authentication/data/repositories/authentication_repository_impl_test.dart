import 'package:education_app/core/error/exceptions.dart';
import 'package:education_app/core/error/failure.dart';
import 'package:education_app/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:education_app/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class AuthenticationRemoteDatasourceMock extends Mock
    implements AuthenticationRemoteDatasource {}

void main() {
  const createdAt = '_empty_string';
  const name = '_empty_string';
  const avatar = '_empty_string';
  const tApiexception =
      ApiException(message: 'Unknown Error occured', statuscode: 500);
  late AuthenticationRemoteDatasource authenticationRemoteDatasource;
  late AuthenticationRepositoryImpl authenticationRepositoryImpl;
  setUp(() {
    authenticationRemoteDatasource = AuthenticationRemoteDatasourceMock();
    authenticationRepositoryImpl = AuthenticationRepositoryImpl(
        authenticationRemoteDatasource: authenticationRemoteDatasource);
  });

  group('createUser', () {
    test(
        'should call the  [ RemoteDataSource.createUser] and complete successful when the call to the remote source is successful',
        () async {
      when(() => authenticationRemoteDatasource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((invocation) async => Future.value());

      final results = await authenticationRepositoryImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(results, equals(const Right(null)));

      verify(() => authenticationRemoteDatasource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(authenticationRemoteDatasource);
    });

    test(
        'should return a [ApiFailure] when the call to the remote source is unsuccessful',
        () async {
      when(
        () => authenticationRemoteDatasource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')),
      ).thenThrow(tApiexception);

      final result = await authenticationRepositoryImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(
          result,
          equals(Left(ApiFailure(
              message: tApiexception.message,
              statusCode: tApiexception.statuscode))));

      verify(
        () => authenticationRemoteDatasource.createUser(
            createdAt: createdAt, name: name, avatar: avatar),
      ).called(1);
      verifyNoMoreInteractions(authenticationRemoteDatasource);
    });
  });

  group('getUser', () {
    test(
        'should call [authenticationRemoteDatasource.getUsers()] and return [List<User>] with correct data',
        () async {
      when(
        () => authenticationRemoteDatasource.getUsers(),
      ).thenAnswer(
        (invocation) async => [],
      );

      final result = await authenticationRepositoryImpl.getUsers();

      expect(result, isA<Right<dynamic, List<User>>>());
      verify(
        () => authenticationRemoteDatasource.getUsers(),
      ).called(1);
      verifyNoMoreInteractions(authenticationRemoteDatasource);
    });

// done by me
    test(
        'should call [Datasource.getUsers()] and throw the proper error whrn data retrievel is unsuccessful',
        () async {
      when(
        () => authenticationRemoteDatasource.getUsers(),
      ).thenThrow(tApiexception);

      final result = await authenticationRepositoryImpl.getUsers();

      expect(
          result,
          Left(ApiFailure(
              message: tApiexception.message,
              statusCode: tApiexception.statuscode)));
      verify(() => authenticationRemoteDatasource.getUsers()).called(1);
      verifyNoMoreInteractions(authenticationRemoteDatasource);
    });
  });

  
}
