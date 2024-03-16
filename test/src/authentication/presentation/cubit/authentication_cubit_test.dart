import 'package:bloc_test/bloc_test.dart';
import 'package:education_app/core/error/failure.dart';
import 'package:education_app/src/authentication/domain/usecase/create_user.dart';
import 'package:education_app/src/authentication/domain/usecase/get_user.dart';
import 'package:education_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUser extends Mock implements GetUser {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUser getUser;
  late CreateUser createUser;
  late AuthenticationCubit authenticationCubit;
  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'message', statusCode: 400);
  setUp(() {
    getUser = MockGetUser();
    createUser = MockCreateUser();
    authenticationCubit =
        AuthenticationCubit(getUsers: getUser, createUser: createUser);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => authenticationCubit.close());

  test('initial state should be [Authentication Initial]', () async {
    expect(authenticationCubit.state, const AuthenticationInitial());
  });

  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [creatingUser,UserCreated] when Successful',
        build: () {
          when(
            () => createUser(any()),
          ).thenAnswer((invocation) async => const Right(null));
          return authenticationCubit;
        },
        act: (cubit) => cubit.createUser(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar),
        expect: () => const [CreatingUser(), UserCreated()],
        verify: (_) {
          verify(
            () => createUser(tCreateUserParams),
          ).called(1);
          verifyNoMoreInteractions(createUser);
        });

    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [Creating User,AuthenticationError] when unsuccessful',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((invocation) async => const Left(tApiFailure));
          return authenticationCubit;
        },
        act: (cubit) => cubit.createUser(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar),
        expect: () => [
              const CreatingUser(),
              AuthenticationErrorState(tApiFailure.message)
            ],
        verify: (_) {
          verify(
            () => createUser(tCreateUserParams),
          ).called(1);
          verifyNoMoreInteractions(createUser);
        });

    group('getUser', () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [GettingUsers,UsersLoaded] when Successful',
        build: () {
          when(
            () => getUser(),
          ).thenAnswer((invocation) async => const Right([]));
          return authenticationCubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => const [GettingUsers(), UserLoaded([])],
        verify: (_) {
          verify(
            () => getUser(),
          ).called(1);
          verifyNoMoreInteractions(getUser);
        },
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
          'should emit [CreatingUser,AuthenticationError] when the event was unsuccessfuk',
          build: () {
            when(
              () => getUser(),
            ).thenAnswer((invocation) async => const Left(tApiFailure));

            return authenticationCubit;
          },
          act: (bloc) => bloc.getUsers(),
          expect: () => [
                const GettingUsers(),
                AuthenticationErrorState(tApiFailure.message)
              ],
              verify: (_) {
          verify(
            () => getUser(),
          ).called(1);
          verifyNoMoreInteractions(getUser);
        },);
    });
  });
}
