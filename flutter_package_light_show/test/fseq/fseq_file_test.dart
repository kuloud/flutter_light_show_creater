import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:light_show/fseq/fseq_file.dart';

void main() {
  test('fseq file read', () {
    final bytes = Uint8List.fromList([
      80, 83, 69, 81, // File Identifier
      0, 0, // Offset to start of channel data
      0, // Minor Version
      1, // Major Version
      0, 32, // Header Length
      0, 0, 0, 100, // Channel Count per Frame
      0, 0, 0, 10, // Number of Frames
      25, // Step Time
      0, // Bit Flags
      0, 1, // Universe Count
      0, 0, // Universe Size
      1, // Gamma
      2, // Color Encoding
      0, 0, // Reserved
      // Compression Block Index (if applicable)
      // Sparse Range Definitions (if applicable)
    ]);

    final fseq = FseqFile.fromBytes(bytes);

    // Access file header information
    print('Filename: ${fseq.filename}');
    print('Unique ID: ${fseq.uniqueId}');
    print('Number of Frames: ${fseq.numFrames}');
    print('Channel Count: ${fseq.channelCount}');
    print('Step Time: ${fseq.stepTime}');
    print('Version Major: ${fseq.versionMajor}');
    print('Version Minor: ${fseq.versionMinor}');

    // Access variable headers
    for (final variableHeader in fseq.variableHeaders) {
      print('Code: ${variableHeader.code}');
      print('Length: ${variableHeader.length}');
      print('Data: ${variableHeader.data}');
    }

    // Save FSEQ file to a new file
    fseq.saveToFile('path/to/new_file.fseq');
  });
}
