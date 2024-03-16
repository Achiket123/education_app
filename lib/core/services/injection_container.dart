import 'package:education_app/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:education_app/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecase/create_user.dart';
import 'package:education_app/src/authentication/domain/usecase/get_user.dart';
import 'package:education_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator

  // application logic
    ..registerFactory(() => AuthenticationCubit(
        getUsers: serviceLocator(), createUser: serviceLocator()))
        // usecases
    ..registerLazySingleton(() => CreateUser(serviceLocator()))
    ..registerLazySingleton(() => GetUser(serviceLocator()))
    // repositories
    ..registerLazySingleton<AuthenticationRepository>(() =>
        AuthenticationRepositoryImpl(
            authenticationRemoteDatasource: serviceLocator()))

      // datasources
    ..registerLazySingleton<AuthenticationRemoteDatasource>(
        () => AuthenticationRemoteDatasourceImpl(client: serviceLocator()))
      
      // External dependency
    ..registerLazySingleton(() => http.Client());
}
