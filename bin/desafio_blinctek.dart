import 'dart:io';
import './modules/Game.dart' show Game;
import './modules/Board.dart';
import './modules/ArtificialPlayer.dart' show ArtificialPlayer;
import './modules/Player.dart' show Player;
import './modules/HumanPlayer.dart' show HumanPlayer;

Game game = Game();
Board board = game.board;

//duas instâncias serão feitas na classe game, no momento da função decidir qual tipo de jogo acontecerá
HumanPlayer playerX = HumanPlayer('\u001b[32mX', 0);
ArtificialPlayer playerO = ArtificialPlayer('\u001b[33mO', 0);

List<Player> players = [playerX, playerO];
List<String> playersValue = [playerX.value, playerO.value];
List chosenCoordinate = [];
int playerInputValue;
bool flag = true;
bool flag2 = true;
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

  while (flag2) {
    while (flag) {
      game.start();

      //Exit Game
      if (playerInputValue == 0) {
        flag = game.quit();
        flag2 = game.quit();
        return;
      }

      board.invalidInputHandler(isValid);

      chosenCoordinate = board.numToCoordinate(playerInputValue);

      isAvailable = board.isFieldAvailable(chosenCoordinate);

      if (!isAvailable) {
        while (!isAvailable) {
          print('');
          stdout.write('\u001b[31mEscolha uma casa livre: ');
          playerInputValue = int.tryParse(stdin.readLineSync());
          isValid = board.validatePlayerInput(playerInputValue);

          board.invalidInputHandler(isValid);

          chosenCoordinate = board.numToCoordinate(playerInputValue);
          isAvailable = board.isFieldAvailable(chosenCoordinate);
        }
      }

      board.writePlayersSymbolAtField(
          coordinate: chosenCoordinate, symbol: '${playersValue[game.turn]}');

      if (flag) {
        flag = board.checkHorizontalWinning(flag);
      }

      if (flag) {
        flag = board.checkVerticalWinning(flag);
      }

      if (flag) {
        flag = board.checkDiagonalWinning(flag);
      }

      if (board.checkTie()) {
        print('\n\u001b[33mO jogo empatou!');
        flag = false;
      }

      if (flag) {
        game.changeTurn();
      }

      //fluid interface
      print('\x1B[2J\x1B[0;0H');
    }
    game.end();
    stdout.write(
        '\u001b[37mDeseja jogar outra partida? (Digite 1 para Sim e 2 para Não): ');
    int restartInput = int.tryParse(stdin.readLineSync());
    game.restart(restartInput);
  }
}
