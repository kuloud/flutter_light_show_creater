import 'package:flutter/material.dart';

class LibraryMusicPage extends StatefulWidget {
  const LibraryMusicPage({super.key});

  @override
  State<LibraryMusicPage> createState() => _LibraryMusicPageState();
}

class _LibraryMusicPageState extends State<LibraryMusicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Music'),
      ),
    );
  }
}
