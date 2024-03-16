
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/usecase/create_user.dart';
import 'package:education_app/src/authentication/domain/usecase/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUser _createUser;
  final GetUser _getUser;
  AuthenticationBloc(
      {required GetUser getUsers, required CreateUser createUser})
      : _getUser = getUsers,
        _createUser = createUser,
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) => emit(LoadingState()));

    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUsersHandler);
  }
  Future<void> _createUserHandler(CreateUserEvent event, Emitter emit) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
        createdAt: event.createdAt, name: event.name, avatar: event.avatar));
    result.fold((l) => emit(AuthenticationErrorState(l.message)),
        (r) => emit(const UserCreated()));
  }

  Future<void> _getUsersHandler(GetUserEvent event, Emitter emit)async {
    emit(const GettingUsers());
    final result =await _getUser();
      result.fold((l) => emit(AuthenticationErrorState(l.message)),
        (r) => emit( UserLoaded(r)));
  }
}
