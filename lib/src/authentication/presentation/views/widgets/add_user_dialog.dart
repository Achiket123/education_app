import 'package:education_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameController;
  const AddUserDialog({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.grey),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(label: Text('username')),
              ),
            const  SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    const avatar =
                        "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/946.jpg";
                    final name = nameController.text.trim();
                    context.read<AuthenticationCubit>().createUser(
                        createdAt: DateTime.now().toString(),
                        name: name,
                        avatar: avatar);
                    nameController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Create User'))
            ],
          ),
        ),
      ),
    );
  }
}
