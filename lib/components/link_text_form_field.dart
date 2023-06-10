import 'package:flutter/material.dart';

class LinkTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const LinkTextFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'youtube link',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter link';
        }
        return null;
      },
    );
  }
}
