import 'dart:io';

void main() async {
  // Read on lien from stdin
  final input = stdin.readLineSync();
  if (input == null) {
    throw Exception('No input provided');
  }

  // Ranges are separated by commas
  final ranges = input.split(',');

  int totalSum = 0;
  for (final range in ranges) {
    final bounds = range.split('-');
    if (bounds.length != 2) {
      throw Exception('Invalid range: $range');
    }
    final start = int.parse(bounds[0]);
    final end = int.parse(bounds[1]);
    totalSum += getSumOfInvalidIdsInRnage(start, end);
  }
  print(totalSum);
}

int getSumOfInvalidIdsInRnage(int start, int end) {
  int sum = 0;
  for (int id = start; id <= end; id++) {
    if (isInvalidId(id)) {
      sum += id;
    }
  }
  return sum;
}

bool isInvalidId(int id) {
  // Now an ID is considerd invalid if it is a sequence of digits (min length 1) repeated twice or more
  final idStr = id.toString();

  for (int len = 1; len <= idStr.length ~/ 2; len++) {
    if (idStr.length % len != 0) {
      continue; // length must divide evenly
    }

    final segment = idStr.substring(0, len);
    final repetitions = idStr.length ~/ len;
    final builtStr = segment * repetitions;

    if (builtStr == idStr) {
      return true;
    }
  }
  return false;
}
