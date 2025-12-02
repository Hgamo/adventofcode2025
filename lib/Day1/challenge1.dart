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

    if (direction == 'R') {
      pointer = (pointer + distance) % 100;
    } else if (direction == 'L') {
      pointer = (pointer - distance) % 100;
    } else {
      throw Exception('Invalid direction: $direction');
    }
    if (pointer == 0) {
      numberOfZeros += 1;
    }
  }

  return numberOfZeros;
}
