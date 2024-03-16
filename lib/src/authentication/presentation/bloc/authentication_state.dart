part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class LoadingState extends AuthenticationState {}

final class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

final class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

final class UserCreated extends AuthenticationState {
  const UserCreated();
}

final class UserLoaded extends AuthenticationState {
  const UserLoaded(this.users);
  final List<User> users;

  @override
  List<Object> get props => users.map((e) => e.id).toList();
}

final class AuthenticationErrorState extends AuthenticationState {
  final String message;
  const AuthenticationErrorState(this.message);
  @override
  List<Object> get props => [message];
}
