import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:education_app/src/authentication/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>serviceLocator<AuthenticationCubit>(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
          ),
          home: const HomePage()),
    );
  }
}
