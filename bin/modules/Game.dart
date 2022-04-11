import 'Board.dart' show Board;
import 'Player.dart' show Player;

class Game {
  Player player = Player('X', 1); //Parâmetros ainda serão implementados
  Board board = Board();
  bool xIsNext;

  Game();

  void play(field) {}

  void quit(flag){
    print('\u001b[37mO jogo foi encerrado!');
    flag = false;
    return;
  }
}
