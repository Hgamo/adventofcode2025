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
  // An ID is considerd invalid if it is a sequence of digits repeated twice
  final idStr = id.toString();
  final len = idStr.length;
  if (len % 2 != 0) {
    return false;
  }

  final half = len ~/ 2;
  final firstHalf = idStr.substring(0, half);
  final secondHalf = idStr.substring(half);

  return firstHalf == secondHalf;
}
