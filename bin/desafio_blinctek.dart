import 'dart:io';
import './modules/Game.dart' show Game;
import './modules/Board.dart';
import './modules/ArtificialPlayer.dart' show ArtificialPlayer;
import './modules/Player.dart' show Player;
import './modules/HumanPlayer.dart' show HumanPlayer;

Game game = Game();

// Instâncias não ocorrerão no arquivo main, apenas na classe Game
Board board = game.board;
HumanPlayer humanPlayer = HumanPlayer('\u001b[32mX', 0);
ArtificialPlayer artificialPlayer = ArtificialPlayer('\u001b[33mO', 0);

List<Player> players = [humanPlayer, artificialPlayer];
List<String> playersValue = [humanPlayer.value, artificialPlayer.value];
List<int> chosenCoordinate = [];
int playerInputValue;
bool moveFlag = true;
bool matchFlag = true;
bool isAvailable = true;
bool isValid = true;

void main(List<String> arguments) {
  //fluid interface
  print('\x1B[2J\x1B[0;0H');

  game.welcome();
  game.chooseMode();

  while (!game.isModeValid()) {
    print('');
    stdout.write('\u001b[31mEscolha um modo de jogo válido: ');
    game.mode = int.tryParse(stdin.readLineSync());
  }
  if (game.mode == 1) {
    humanPlayer.go();
  } else if (game.mode == 2) {
    artificialPlayer.go();
  }
}
