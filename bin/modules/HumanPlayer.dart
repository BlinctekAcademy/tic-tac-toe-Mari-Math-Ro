import 'Player.dart' show Player;
import 'dart:io';

class HumanPlayer extends Player {
  HumanPlayer(String _value, int _score) : super(_value, _score);

  int getMove() {
    return int.tryParse(stdin.readLineSync());
  }
}
