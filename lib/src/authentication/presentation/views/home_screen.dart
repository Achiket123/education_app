import 'package:education_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:education_app/src/authentication/presentation/views/widgets/add_user_dialog.dart';
import 'package:education_app/src/authentication/presentation/views/widgets/loading_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();

  void getUser() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCreated) {
          getUser();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: state is GettingUsers
              ? const LoadingColumn(message: 'Fetching User')
              : state is CreatingUser
                  ? const LoadingColumn(message: 'Creating User')
                  : state is UserLoaded
                      ? Center(
                          child: ListView.builder(
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return ListTile(
                              title: Text(
                                user.name,
                              ),
                              leading: Image.network(user.avatar),
                              subtitle: Text(user.createdat.substring(10)),
                            );
                          },
                          itemCount: state.users.length,
                        ))
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AddUserDialog(
                        nameController: _nameController,
                      ));
            },
            tooltip: 'Add User',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
