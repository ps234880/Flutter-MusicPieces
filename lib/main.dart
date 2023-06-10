import 'package:flutter/material.dart';
import 'package:music_pieces/pages/login_page.dart';
import 'package:music_pieces/pages/main_page.dart';

void main() {
  runApp(const MusicPieces());
}

class MusicPieces extends StatefulWidget {
  const MusicPieces({Key? key}) : super(key: key);

  @override
  State<MusicPieces> createState() => _MusicPiecesState();
}

class _MusicPiecesState extends State<MusicPieces> {
  bool _signedIn = false;

  void setSignedIn(bool signedIn) {
    setState(() {
      _signedIn = signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _signedIn
          ? MainPage(setSignedIn: setSignedIn)
          : LoginPage(setSignedIn: setSignedIn),
    );
  }
}
