import 'package:education_app/core/error/exceptions.dart';
import 'package:education_app/core/error/failure.dart';
import 'package:education_app/core/utils/typedeff.dart';
import 'package:education_app/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:fpdart/fpdart.dart';

// DEPENDENCY INVERSION
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDatasource _authenticationRemoteDatasource;

  AuthenticationRepositoryImpl(
      {required AuthenticationRemoteDatasource authenticationRemoteDatasource})
      : _authenticationRemoteDatasource = authenticationRemoteDatasource;

  @override
  ResultFuture<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await _authenticationRemoteDatasource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _authenticationRemoteDatasource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
