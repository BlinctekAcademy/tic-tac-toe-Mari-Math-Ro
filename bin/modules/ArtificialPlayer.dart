import 'Player.dart' show Player;

class ArtificialPlayer extends Player {
  List<List<int>> scoreBoard;

  ArtificialPlayer(String _value, int _score) : super(_value, _score);

  calculate(List<List<String>> board) {}

  minimax() {}
}
