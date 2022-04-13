import 'dart:io';
import './modules/Game.dart' show Game;
import './modules/Board.dart';
import './modules/ArtificialPlayer.dart' show ArtificialPlayer;
import './modules/Player.dart' show Player;
import 'modules/HumanPlayer.dart';

Game game = Game();
Board board = game.board;
ArtificialPlayer artificialPlayer = ArtificialPlayer('O', 0);

//duas instâncias serão feitas na classe game, no momento da função decidir qual tipo de jogo acontecerá
HumanPlayer playerX = HumanPlayer('\u001b[32mX', 0);
Player playerO = Player('\u001b[33mO', 0);

List<String> players = [playerX.value, playerO.value];
List chosenCoordinate = [];
int playerInputValue;
bool flag = true;
bool isAvailable = true;
bool isValid = true;

void main(List<String> arguments) {
  //fluid interface
  print('\x1B[2J\x1B[0;0H');
  game.welcome();
  game.chooseMode();
  if (!game.isModeValid()) {
    while (!game.isModeValid()) {
      print('');
      stdout.write('\u001b[31mEscolha um valor válido: ');
      game.mode = int.tryParse(stdin.readLineSync());
      //game.isModeValid() = board.validateGameMode(game.mode);
    }
  }

  game.start();
  //return;
  // artificialPlayer.start();
  while (flag) {
    board.render(board.representation);
    stdout.write(
        '\u001b[37mJogador ${players[game.turn]}\u001b[37m, faça sua jogada (Pressione 0 para fechar o jogo): ');
    playerInputValue = int.tryParse(stdin.readLineSync());

    isValid = board.validatePlayerInput(playerInputValue);

    //Exit Game
    if (playerInputValue == 0) {
      flag = game.quit();
      return;
    }

    //LEMBRETE: TRANSFORMAR EM FUNÇÃO
    if (isValid == false) {
      while (isValid == false) {
        print('');
        stdout.write('\u001b[31mEscolha um valor válido: ');
        playerInputValue = int.tryParse(stdin.readLineSync());
        isValid = board.validatePlayerInput(playerInputValue);
      }
    }

    chosenCoordinate = board.numToCoordinate(playerInputValue);

    isAvailable = board.isFieldAvailable(chosenCoordinate);

    if (isAvailable == false) {
      while (isAvailable == false) {
        print(' ');
        stdout.write('\u001b[31mEscolha uma casa livre: ');
        playerInputValue = int.tryParse(stdin.readLineSync());
        isValid = board.validatePlayerInput(playerInputValue);

        //CHAMAR FUNÇÃO A SER CRIADA
        if (isValid == false) {
          while (isValid == false) {
            print('');
            stdout.write('\u001b[31mEscolha um valor válido: ');
            playerInputValue = int.tryParse(stdin.readLineSync());
            isValid = board.validatePlayerInput(playerInputValue);
          }
        }

        chosenCoordinate = board.numToCoordinate(playerInputValue);
        isAvailable = board.isFieldAvailable(chosenCoordinate);
      }
    }

    board.writePlayersSymbolAtField(
        coordinate: chosenCoordinate, symbol: '${players[game.turn]}');

    if (flag) {
      flag = board.checkHorizontalWinning(flag);
    }

    if (flag) {
      flag = board.checkVerticalWinning(flag);
    }

    if (flag) {
      flag = board.checkDiagonalWinning(flag);
    }

    if (board.checkTie(flag)) {
      print('\n\u001b[33mO jogo empatou!');
      flag = false;
      return;
    }

    if (flag) {
      game.changeTurn();
    }

    //fluid interface
    print('\x1B[2J\x1B[0;0H');
  }

  board.render(board.representation);
  if (players[game.turn] == '\u001b[32mX' ||
      players[game.turn] == '\u001b[33mO') {
    print('\n\u001b[37mO jogador ${players[game.turn]} \u001b[37mganhou!');
    return;
  }
}
