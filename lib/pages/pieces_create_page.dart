// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_pieces/components/link_text_form_field.dart';
import 'package:music_pieces/components/name_text_form_field.dart';
import 'package:music_pieces/components/composer_text_form_field.dart';
import 'package:music_pieces/models/genre.dart';
import 'package:music_pieces/services/pieces_services.dart';

class PiecesCreatePage extends StatefulWidget {
  final Genre genre;

  const PiecesCreatePage({Key? key, required this.genre}) : super(key: key);

  @override
  State<PiecesCreatePage> createState() => _PiecesCreatePageState();
}

class _PiecesCreatePageState extends State<PiecesCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _linkController = TextEditingController();
  final _composerController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _linkController.dispose();
    _composerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Pieces - Add - ${widget.genre.name}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Genre name
                Row(children: [
                  Text(
                    widget.genre.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ]),

                // Name
                const SizedBox(height: 20),
                NameTextFormField(controller: _nameController),

                // Composer
                const SizedBox(height: 20),
                ComposerTextFormField(controller: _composerController),

                // Link
                const SizedBox(height: 20),
                LinkTextFormField(controller: _linkController),

                // Buttons Save and Cancel
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await PiecesServices.create(
                            name: _nameController.text,
                            composer: _composerController.text,
                            link: _linkController.text,
                            genreId: widget.genre.id,
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[900],
                      ),
                      child: const Text('Add'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[900],
                      ),
                      child: const Text('Cancel'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
