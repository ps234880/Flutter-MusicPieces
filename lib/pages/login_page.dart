import 'package:flutter/material.dart';
import 'package:music_pieces/services/authentication_services.dart';
import 'package:music_pieces/components/email_text_form_field.dart';
import 'package:music_pieces/components/password_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.setSignedIn}) : super(key: key);

  final void Function(bool signedIn) setSignedIn;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Aligns the content vertically and horizontally centered
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email input field
              EmailTextFormField(controller: _emailTextController),
              const SizedBox(height: 10), // Small gap between input fields

              // Password input field
              PasswordTextFormField(controller: _passwordTextController),
              const SizedBox(height: 10), // Small gap below input fields

              // Submit button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final result = await AuthenticationServices.login(
                        _emailTextController.text,
                        _passwordTextController.text,
                      );
                      widget.setSignedIn(result);
                    } catch (e) {
                      widget.setSignedIn(false);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 45),
                  backgroundColor: Colors.teal[900],
                ),
                child: const Text('Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
