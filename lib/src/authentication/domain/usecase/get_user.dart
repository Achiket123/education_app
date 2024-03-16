import 'package:education_app/core/ussecase/usecase.dart';
import 'package:education_app/core/utils/typedeff.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';

class GetUser extends UseCasewithoutParams<List<User>> {
  final AuthenticationRepository _repository;

  GetUser(AuthenticationRepository repository)
      : _repository = repository;

  @override
  ResultFuture<List<User>> call() async {
    return await _repository.getUsers();
  }
}
