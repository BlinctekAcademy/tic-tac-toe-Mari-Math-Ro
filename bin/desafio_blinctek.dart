import 'module.dart' as module;
import 'dart:io';
import './modules/Game.dart' show Game;
import './modules/Board.dart';

Game game = Game();
Board board = game.board;

List<String> players = ['\u001b[32mX', '\u001b[33mO'];
int turn = 0;
List chosenCoordinate = [];
int playerInputValue;
bool flag = true;
bool isAvailable = true;
bool isValid = true;

void main(List<String> arguments) {
  //fluid interface
  print('\x1B[2J\x1B[0;0H');

  while (flag) {
    board.render(board.representation);

    stdout.write(
        '\u001b[37mJogador ${players[turn]}\u001b[37m, faça sua jogada (Pressione 0 para fechar o jogo): ');
    playerInputValue = int.tryParse(stdin.readLineSync());

    isValid = module.checkValidity(playerInputValue);

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
        isValid = module.checkValidity(playerInputValue);
      }
    }

    chosenCoordinate = module.numToCoordinate(playerInputValue);

    isAvailable =
        module.checkAvailability(board.representation, chosenCoordinate);

    if (isAvailable == false) {
      while (isAvailable == false) {
        print(' ');
        stdout.write('\u001b[31mEscolha uma casa livre: ');
        playerInputValue = int.tryParse(stdin.readLineSync());
        isValid = module.checkValidity(playerInputValue);

        //CHAMAR FUNÇÃO A SER CRIADA
        if (isValid == false) {
          while (isValid == false) {
            print('');
            stdout.write('\u001b[31mEscolha um valor válido: ');
            playerInputValue = int.tryParse(stdin.readLineSync());
            isValid = module.checkValidity(playerInputValue);
          }
        }

        chosenCoordinate = module.numToCoordinate(playerInputValue);
        isAvailable =
            module.checkAvailability(board.representation, chosenCoordinate);
      }
    }

    module.writePlayersSymbolAtField(
        board: board.representation,
        coordinate: chosenCoordinate,
        symbol: '${players[turn]}');

    if (flag) {
      flag = module.horizontalCheck(board.representation, flag);
    }

    if (flag) {
      flag = module.verticalCheck(board.representation, flag);
    }

    if (flag) {
      flag = module.diagonalCheck(board.representation, flag);
    }

    if (module.checkTie(board.representation, flag)) {
      print('\n\u001b[33mO jogo empatou!');
      flag = false;
      return;
    }

    if (flag) {
      turn = module.changeTurn(turn);
    }

    //fluid interface
    print('\x1B[2J\x1B[0;0H');
  }

  board.render(board.representation);
  if (players[turn] == '\u001b[32mX') {
    print('\n\u001b[37mO jogador ${players[turn]} \u001b[37mganhou!');
    return;
  } else if (players[turn] == '\u001b[33mO') {
    print('\n\u001b[37mO jogador ${players[turn]} \u001b[37mganhou!');
  }
}
