import 'Player.dart' show Player;
import '../desafio_blinctek.dart';
import 'dart:io';

class HumanPlayer extends Player {
  HumanPlayer(String _value, int _score) : super(_value, _score);

  void go() {
    while (matchFlag) {
      while (moveFlag) {
        game.start();

        //fluid interface
        print('\x1B[2J\x1B[0;0H');

        //Exit Game
        if (playerInputValue == 0) {
          matchFlag = game.quit();
          return;
        }

        board.invalidInputHandler(isValid);

        chosenCoordinate = board.numToCoordinate(playerInputValue);

        isAvailable = board.isFieldAvailable(chosenCoordinate);

        while (!isAvailable) {
          print('');
          board.render(board.representation);
          stdout.write('\u001b[31mEscolha uma casa livre: ');
          playerInputValue = int.tryParse(stdin.readLineSync());
          isValid = board.validatePlayerInput(playerInputValue);

          board.invalidInputHandler(isValid);

          chosenCoordinate = board.numToCoordinate(playerInputValue);
          isAvailable = board.isFieldAvailable(chosenCoordinate);
        }

        board.writePlayersSymbolAtField(
            coordinate: chosenCoordinate, symbol: '${playersValue[game.turn]}');

        if (board.checkWin()) {
          print(
              '\n\u001b[37mO jogador \u001b[32m${playersValue[game.turn]} \u001b[37mganhou!');
          break;
        }

        if (board.checkTie()) {
          board.render(board.representation);
          print('\x1B[33mO jogo empatou!');
          break;
        }

        game.changeTurn();

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

  void play() {
    stdout.write(
        '\u001b[37mJogador ${playersValue[game.turn]}\u001b[37m, faça sua jogada (Pressione 0 para fechar o jogo): ');
    //O valor de playerInputValue só ocorria pois a variável esta sendo alterada neste momento
    //por ter tentado retornar o valor da função, essa variável foi excluída, logo, o valor retornado sempre era nulo
    playerInputValue = int.tryParse(stdin.readLineSync());
  }
}
