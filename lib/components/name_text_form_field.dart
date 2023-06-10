import 'package:flutter/material.dart';

class NameTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const NameTextFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'name',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter name';
        }
        return null;
      },
    );
  }
}
