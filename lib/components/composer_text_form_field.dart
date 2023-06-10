import 'package:flutter/material.dart';

class ComposerTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const ComposerTextFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'composer',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter composer';
        }
        return null;
      },
    );
  }
}
