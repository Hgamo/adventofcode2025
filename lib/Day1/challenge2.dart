import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() async {
  // Read the the input from stdin+
  final input = stdin.transform(utf8.decoder).transform(const LineSplitter());
  print(await solver(input));
}

Future<int> solver(Stream<String> lines) async {
  // The pointer starts at 50 and can go from 0 to 99
  int pointer = 50;

  int numberOfZeros = 0;

  await for (final line in lines) {
    // A line is ether R or L followed by a number
    final direction = line[0];
    final distance = int.parse(line.substring(1));

    // Count how many times we land on 0 during the rotation
    if (direction == 'R') {
      // Moving right from pointer, how many times do we hit 0?
      // We hit 0 at distances: (100 - pointer), (200 - pointer), etc.
      // The first time we hit 0 is at distance (100 - pointer) % 100
      // But if pointer is already 0, first hit is at distance 0 (which we skip, not a rotation)

      int firstZero = (100 - pointer) % 100;
      if (firstZero == 0) {
        firstZero = 100; // if already at 0, next 0 is 100 steps away
      }

      if (distance >= firstZero) {
        // We hit 0 at least once
        // Count: 1 + how many more times after the first
        numberOfZeros += 1 + ((distance - firstZero) ~/ 100);
      }

      pointer = (pointer + distance) % 100;
    } else if (direction == 'L') {
      // Moving left from pointer, how many times do we hit 0?
      // We hit 0 at distances: pointer, pointer + 100, pointer + 200, etc.

      int firstZero = pointer;
      if (firstZero == 0) {
        firstZero = 100; // if already at 0, next 0 is 100 steps away
      }

      if (distance >= firstZero) {
        // We hit 0 at least once
        numberOfZeros += 1 + ((distance - firstZero) ~/ 100);
      }

      pointer = ((pointer - distance) % 100 + 100) % 100;
    } else {
      throw Exception('Invalid direction: $direction');
    }
  }

  return numberOfZeros;
}
