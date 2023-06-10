import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<void> _showAboutDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AboutDialog(
          applicationName: 'Music Pieces',
          applicationVersion: '1.0.0+1',
          applicationIcon: Icon(Icons.info_outline),
          children: [
            Text('I love working with FLutter!'),
            Text('It`s the best'),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'About',
        ),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: _showAboutDialog,
          ),
        ],
      ),
      body: Padding(
        // Add padding to the whole column
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Align children at the start of the cross axis (horizontally)
          crossAxisAlignment: CrossAxisAlignment.start,
          // Create a list of widgets
          children: const <Widget>[
            Text(
              'About this App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'This app is a classical music CRUD that displays information about different pieces.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Built with Flutter by Tong Sheng Zhang',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '\u00a9 2023. All rights reserved.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
