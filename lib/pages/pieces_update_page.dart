import 'package:flutter/material.dart';
import 'package:music_pieces/components/name_text_form_field.dart';
import 'package:music_pieces/models/genre.dart';
import 'package:music_pieces/models/piece.dart';
import 'package:music_pieces/services/genres_services.dart';
import 'package:music_pieces/services/pieces_services.dart';
import 'package:music_pieces/components/composer_text_form_field.dart';
import 'package:music_pieces/components/link_text_form_field.dart';

class PiecesUpdatePage extends StatefulWidget {
  final Piece piece;

  const PiecesUpdatePage({
    Key? key,
    required this.piece,
  }) : super(key: key);

  @override
  State<PiecesUpdatePage> createState() => _PiecesUpdatePageState();
}

class _PiecesUpdatePageState extends State<PiecesUpdatePage> {
  Genre? _selectedGenre;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _composerController = TextEditingController();
  final _linkController = TextEditingController();

  final PiecesServices piecesServices =
      PiecesServices(); // Create an instance of PiecesServices

  void _refreshIndex(Genre selectedGenre) {
    setState(() {
      // Update selected genre in the state
      _selectedGenre = selectedGenre;
    });
  }

  @override
  void initState() {
    _nameController.text = widget.piece.name;
    _composerController.text = widget.piece.composer;
    _linkController.text = widget.piece.link;
    super.initState();
  }

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
        title: const Text('Pieces - Edit'),
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Dropdown with genres
                Row(children: [_cmbGenres()]),

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
                          // Update the piece using PiecesServices
                          await PiecesServices.update(
                            pieceId: widget.piece.id,
                            name: _nameController.text,
                            composer: _composerController.text,
                            link: _linkController.text,
                            genreId: _selectedGenre!.id,
                          );
                          // Check if the context is still available
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[900],
                      ),
                      child: const Text('Save'),
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

  FutureBuilder<List<Genre>> _cmbGenres() {
    return FutureBuilder<List<Genre>>(
      future: GenreServices.getAll(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Genre> genres = snapshot.data!;

        // Find the genre of the piece and set it as the selected genre
        // Note: If a genre was already selected, the value should remain unchanged
        _selectedGenre ??=
            genres.firstWhere((element) => element.id == widget.piece.genreId);

        return DropdownButton<Genre>(
          value: _selectedGenre,
          icon: const Icon(Icons.arrow_downward),
          underline: Container(height: 2, color: Colors.teal[900]),
          onChanged: (Genre? value) {
            // This is called when the user selects an item.
            _refreshIndex(value!);
          },
          items: genres.map<DropdownMenuItem<Genre>>((Genre value) {
            return DropdownMenuItem<Genre>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
        );
      },
    );
  }
}
