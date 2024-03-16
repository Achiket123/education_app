import 'package:education_app/core/ussecase/usecase.dart';
import 'package:education_app/core/utils/typedeff.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UseCasewithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;
  CreateUser(this._repository);
  @override
  ResultFuture<void> call(CreateUserParams params) async {
    return await _repository.createUser(
        createdAt: params.createdAt, name: params.name, avatar: params.avatar);
  }
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams(
      {required this.createdAt, required this.name, required this.avatar});
  const CreateUserParams.empty()
      : this(
            avatar: '_empty_.string',
            name: '_empty_.string',
            createdAt: '_empty_.string');

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
