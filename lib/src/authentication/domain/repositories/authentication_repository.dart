import 'package:education_app/core/utils/typedeff.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';

abstract interface class AuthenticationRepository {
  const AuthenticationRepository();

 ResultFuture<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  ResultFuture<List<User>> getUsers();
}
