import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/usecase/create_user.dart';
import 'package:education_app/src/authentication/domain/usecase/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CreateUser _createUser;
  final GetUser _getUser;
   AuthenticationCubit(
      {required GetUser getUsers, required CreateUser createUser})
      : _getUser = getUsers,
        _createUser = createUser,
        super(const AuthenticationInitial());

  Future<void> createUser({required String createdAt,required String name,required String avatar})async {
    emit(const CreatingUser(
     
    ));

    final result = await _createUser(CreateUserParams(
        createdAt: createdAt, name:name,avatar: avatar));
    result.fold((l) => emit(AuthenticationErrorState(l.message)),
        (r) => emit(const UserCreated()));}


  Future<void> getUsers()async{
    emit(const GettingUsers());
    final result =await _getUser();
      result.fold((l) => emit(AuthenticationErrorState(l.message)),
        (r) => emit( UserLoaded(r)));


  }
}
