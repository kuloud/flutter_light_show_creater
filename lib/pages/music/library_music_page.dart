import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class LibraryMusicPage extends StatefulWidget {
  const LibraryMusicPage({super.key});

  @override
  State<LibraryMusicPage> createState() => _LibraryMusicPageState();
}

class _LibraryMusicPageState extends State<LibraryMusicPage> {
  List<File> musicFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: musicFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(musicFiles[index].path),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          importMusic();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> importMusic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        musicFiles = result.paths.map((path) => File(path!)).toList();
      });
    }
  }
}
