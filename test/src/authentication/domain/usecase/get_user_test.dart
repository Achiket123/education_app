import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecase/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUser usecase;
  late AuthenticationRepository repository;
  setUp(() {
    repository = MockAuthenticationRepoitory();
    usecase = GetUser(repository);
  });

  final tResponse = [const User.empty()];
  test(
      'should call [AuthenticationRepository.getUsers] and return [List<Users>]',
      () async {
    when(
      () => repository.getUsers(),
    ).thenAnswer((invocation) async => Right(tResponse));

    final result = await usecase();
    expect(result, equals(Right<dynamic, List<User>>(tResponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
