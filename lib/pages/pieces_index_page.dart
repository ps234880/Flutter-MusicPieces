import 'package:flutter/material.dart';
import 'package:music_pieces/models/genre.dart';
import 'package:music_pieces/models/piece.dart';
import 'package:music_pieces/pages/pieces_create_page.dart';
import 'package:music_pieces/pages/pieces_update_page.dart';
import 'package:music_pieces/services/genres_services.dart';
import 'package:music_pieces/services/pieces_services.dart';

class PiecesIndexPage extends StatefulWidget {
  const PiecesIndexPage({Key? key, required this.setSignedIn})
      : super(key: key);

  final void Function(bool signedIn) setSignedIn;

  @override
  State<PiecesIndexPage> createState() => _PiecesIndexState();
}

class _PiecesIndexState extends State<PiecesIndexPage> {
  List<Piece>? posts;
  bool isLoaded = false;

  Future<List<Piece>>? _pieces;
  Genre? _selectedGenre;

  void _refreshIndex(Genre selectedGenre) {
    setState(() {
      // Update selected genre in the state
      _selectedGenre = selectedGenre;

      // Update list of pieces
      _pieces = PiecesServices.getAllByGenre(genreId: _selectedGenre!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pieces Index'),
        actions: [_logout()],
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButton: _buttonCreatePieces(),
      body: Column(
        children: [
          // Dropdown with genres
          _cmbGenres(),
          const SizedBox(height: 20),
          // List of pieces
          Expanded(child: _listPieces()),
        ],
      ),
    );
  }

  IconButton _logout() {
    return IconButton(
      onPressed: () {
        widget.setSignedIn(false);
      },
      icon: const Icon(Icons.logout),
    );
  }

  FloatingActionButton _buttonCreatePieces() {
    return FloatingActionButton(
      backgroundColor: Colors.teal[900],
      onPressed: () async {
        Genre selectedGenre = _selectedGenre!;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PiecesCreatePage(genre: selectedGenre),
        ));
        _refreshIndex(selectedGenre);
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }

  IconButton _btnUpdatePiece({required Piece piece}) {
    return IconButton(
      onPressed: () async {
        Genre selectedGenre = _selectedGenre!;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PiecesUpdatePage(piece: piece),
        ));
        _refreshIndex(selectedGenre);
      },
      icon: const Icon(
        Icons.edit,
        color: Colors.teal,
      ),
    );
  }

  IconButton _btnDeletePiece({required Piece piece}) {
    return IconButton(
      onPressed: () async {
        await PiecesServices.delete(pieceId: piece.id);
        _refreshIndex(_selectedGenre!);
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
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

        // Dropdown for genres
        return DropdownButton<Genre>(
          value: _selectedGenre ?? genres.first,
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

  Widget _listPieces() {
    return _pieces == null
        ? const Center(
            child: CircularProgressIndicator(),
          ) // Show a loading indicator when pieces data is null
        : FutureBuilder(
            future: _pieces,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                ); // Show an error message if there is an error
              }
              if (snapshot.hasData == false) {
                return const Center(
                  child: CircularProgressIndicator(),
                ); // Show a loading indicator while waiting for data
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(
                        '${snapshot.data![index].composer} - ${snapshot.data![index].link} '),
                    leading: _btnUpdatePiece(piece: snapshot.data![index]),
                    trailing: _btnDeletePiece(piece: snapshot.data![index]),
                  );
                },
              );
            },
          );
  }
}
