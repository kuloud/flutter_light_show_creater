import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> getDocumentsDirectory() async {
  final cacheDir = await getApplicationDocumentsDirectory();
  return cacheDir.path;
}

void copyFile(String sourcePath, String destinationPath) {
  final sourceFile = File(sourcePath);
  final destinationFile = File(destinationPath);

  if (destinationFile.existsSync()) {
    destinationFile.deleteSync();
  }

  sourceFile.copySync(destinationPath);
}
