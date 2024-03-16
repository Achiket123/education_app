
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecase/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';


void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;
  setUp(() {
    repository = MockAuthenticationRepoitory();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();
  test('it should call the AuthenticationRepository.createUser()', () async {
    when(() => repository.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')))
        .thenAnswer((invocation) async => right(null));
    final result = await usecase.call(params);

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar)).called(1);

    verifyNoMoreInteractions(repository);
  });
}
