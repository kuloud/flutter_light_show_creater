import 'dart:io';
import 'dart:typed_data';

import 'package:light_show/fseq/fseq_file_v2.dart';

/// References:
/// https://github.com/Cryptkeeper/fseq-file-format
/// https://github.com/FalconChristmas/fpp/blob/master/docs/FSEQ_Sequence_File_Format.txt
///

class FseqFile {
  FseqHeader header;

  FseqFile({
    required this.header,
  });

  static FseqFile fromBytes(Uint8List bytes) {
    final fileIdentifier = String.fromCharCodes(bytes.sublist(0, 4));
    if (fileIdentifier != 'PSEQ') {
      throw FormatException('Unsupport fileIdentifier: $fileIdentifier');
    }
    final majorVersion = bytes[7];

    if (majorVersion >= 2) {
      return FseqV2File.fromBytes(bytes);
    }

    // TODO ignore V1
    return FseqV2File.fromBytes(bytes);
  }

  static FseqFile openFile(File file) {
    final bytes = file.readAsBytesSync();
    return fromBytes(bytes);
  }

  // void saveToFile(String filePath) {
  //   final bytes = toBytes();
  //   final file = File(filePath);
  //   file.writeAsBytesSync(bytes);
  // }
}

class FseqHeader {
  String fileIdentifier;
  int offsetToChannelData;
  int minorVersion;
  int majorVersion;
  int headerLength;
  int channelCountPerFrame;
  int numberOfFrames;
  int stepTime;
  int bitFlags;

  FseqHeader({
    required this.fileIdentifier,
    required this.offsetToChannelData,
    required this.minorVersion,
    required this.majorVersion,
    required this.headerLength,
    required this.channelCountPerFrame,
    required this.numberOfFrames,
    required this.stepTime,
    required this.bitFlags,
  });
}
