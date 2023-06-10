import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordTextFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'password',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter password';
        }
        return null;
      },
    );
  }
}
