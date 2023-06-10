import 'package:flutter/material.dart';
import 'package:music_pieces/pages/about_page.dart';
import 'package:music_pieces/pages/pieces_home_page.dart';
import 'package:music_pieces/pages/pieces_index_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.setSignedIn}) : super(key: key);

  final void Function(bool signedIn) setSignedIn;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.grey[900],
          child: const TabBar(
            tabs: [
              // Home tab
              Tab(icon: Icon(Icons.home_outlined)),
              // Pieces tab
              Tab(icon: Icon(Icons.music_note_outlined)),
              // About tab
              Tab(icon: Icon(Icons.info_outline)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Home page
            const PiecesHomePage(),
            // Pieces index page
            PiecesIndexPage(setSignedIn: widget.setSignedIn),
            // About page
            const AboutPage(),
          ],
        ),
      ),
    );
  }
}
