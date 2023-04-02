import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/budget_bloc.dart';
import '../data/user.dart';
import '../routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final budgetLimitController = TextEditingController();
    return Scaffold(
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: firstNameController,
                    maxLength: 20,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        suffixIcon: Icon(Icons.person),
                        helperText: "*Required for identification"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: lastNameController,
                    maxLength: 20,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                        suffixIcon: Icon(Icons.person),
                        helperText: "*Required for identification"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: budgetLimitController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Budget Limit',
                        suffixIcon: Icon(Icons.money)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<BudgetBloc>(context).add(RegisterUser(
                          user: User(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              budgetLimit: 0)));
                      Navigator.popAndPushNamed(context, Routes.home);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50)),
                    child: const Text("SUBMIT"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
