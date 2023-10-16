import 'dart:typed_data';

import 'package:light_show/fseq/fseq_file.dart';

class FseqV2File extends FseqFile {
  FseqV2File({
    required super.header,
  });

  static FseqFile fromBytes(Uint8List bytes) {
    // file identifier, must be 'PSEQ'
    final fileIdentifier = String.fromCharCodes(bytes.sublist(0, 4));
    final offsetToChannelData = bytes[4] << 8 | bytes[5];
    final minorVersion = bytes[6];
    final majorVersion = bytes[7];
    // standard header length/index to first variable header
    final headerLength = bytes[8] << 8 | bytes[9];
    final channelCountPerFrame =
        bytes[10] << 24 | bytes[11] << 16 | bytes[12] << 8 | bytes[13];
    final numberOfFrames =
        bytes[14] << 24 | bytes[15] << 16 | bytes[16] << 8 | bytes[17];
    // step time in ms, usually 25 or 50
    final stepTime = bytes[18];
    // bit flags/reserved should be 0
    final bitFlags = bytes[19];

    List<int>? compressBlockIndex;
    List<SparseRange>? sparseRanges;

    /// compression type 0 for uncompressed, 1 for zstd, 2 for libz/gzip
    final compressionType = bytes[20] & 0x0F;
    final numberOfCompressionBlocks =
        ((bytes[20] & 0xF0) >> 4) | (bytes[21] << 4);
    final numberOfSparseRanges = bytes[22];
    final bitFlagsV2 = bytes[23];

    int offset = 28;

    if (numberOfCompressionBlocks > 0) {
      compressBlockIndex = [];
      for (int i = 0; i < numberOfCompressionBlocks; i++) {
        final frameNumber = bytes[offset] |
            bytes[offset + 1] << 8 |
            bytes[offset + 2] << 16 |
            bytes[offset + 3] << 24;
        final lengthOfBlock = bytes[offset + 4] |
            bytes[offset + 5] << 8 |
            bytes[offset + 6] << 16 |
            bytes[offset + 7] << 24;

        compressBlockIndex.add(frameNumber);
        compressBlockIndex.add(lengthOfBlock);

        offset += 8;
      }
    }

    // Parse sparse range definitions
    if (numberOfSparseRanges > 0) {
      sparseRanges = [];
      for (int i = 0; i < numberOfSparseRanges; i++) {
        final startChannelNumber =
            bytes[offset] | bytes[offset + 1] << 8 | bytes[offset + 2] << 16;
        final numberOfChannels = bytes[offset + 3] |
            bytes[offset + 4] << 8 |
            bytes[offset + 5] << 16;

        final sparseRange = SparseRange(
          startChannelNumber: startChannelNumber,
          numberOfChannels: numberOfChannels,
        );

        sparseRanges.add(sparseRange);

        offset += 6;
      }
    }

    final header = FseqV2Header(
        fileIdentifier: fileIdentifier,
        offsetToChannelData: offsetToChannelData,
        minorVersion: minorVersion,
        majorVersion: majorVersion,
        headerLength: headerLength,
        channelCountPerFrame: channelCountPerFrame,
        numberOfFrames: numberOfFrames,
        stepTime: stepTime,
        bitFlags: bitFlags,
        compressBlockIndex: compressBlockIndex,
        sparseRanges: sparseRanges);

    return FseqV2File(header: header);
  }
}

class FseqV2Header extends FseqHeader {
  List<int>? compressBlockIndex;
  List<SparseRange>? sparseRanges;

  FseqV2Header(
      {required super.fileIdentifier,
      required super.offsetToChannelData,
      required super.minorVersion,
      required super.majorVersion,
      required super.headerLength,
      required super.channelCountPerFrame,
      required super.numberOfFrames,
      required super.stepTime,
      required super.bitFlags,
      required this.compressBlockIndex,
      required this.sparseRanges});
}

class SparseRange {
  int startChannelNumber;
  int numberOfChannels;

  SparseRange({
    required this.startChannelNumber,
    required this.numberOfChannels,
  });
}
