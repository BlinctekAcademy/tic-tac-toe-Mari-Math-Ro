import 'dart:io';
import '../desafio_blinctek.dart';
import 'Board.dart' show Board;
import 'HumanPlayer.dart' show HumanPlayer;
import 'ArtificialPlayer.dart' show ArtificialPlayer;

class Game {
  HumanPlayer playerX = HumanPlayer('\u001b[32mX', 0);
  Board board = Board();
  int turn = 0;
  int mode; //vs human or vs AI

  Game();

  void welcome() {
    print('Seja bem vindo ao Jogo da Velha!');
  }

  void chooseMode() {
    stdout.write(
        'Você deseja jogar contra um amigo ou a CPU? (Digite 1 para amigo e 2 para CPU): ');
    this.mode = int.tryParse(stdin.readLineSync());
    isModeValid();
    //return this.mode;
  }

  bool isModeValid() {
    return this.board.validateGameMode(this.mode);
  }

  void start() {
    this.board.render(board.representation);
    if (this.mode == 1) {
      this.playWithHuman();
    } else if (this.mode == 2) {
      this.playWithAI();
    }

    isValid = board.validatePlayerInput(playerInputValue);
  }

  void playWithHuman() {
    HumanPlayer playerO = HumanPlayer('\u001b[33mO', 0);
    stdout.write(
        '\u001b[37mJogador ${playersValue[game.turn]}\u001b[37m, faça sua jogada (Pressione 0 para fechar o jogo): ');
    playerInputValue = int.tryParse(stdin.readLineSync());
  }

  void playWithAI() {
    ArtificialPlayer playerO = ArtificialPlayer('\u001b[33mO', 0);
    stdout.write(
        '\u001b[37mJogador X\u001b[37m, faça sua jogada (Pressione 0 para fechar o jogo): ');
    int playerXFieldInput = int.tryParse(stdin.readLineSync());
  }

  void changeTurn() {
    turn = turn == 1 ? 0 : 1;
  }

//receber o valor do input de restart, if == 1, chame start(), if == 2, chame quit()
  void restart(input) {
    input = board.invalidRestartInputHandler(
        board.validateRestartInput(input), input);
    if (input == 1) {
      moveFlag = true;
      matchFlag = true;
      board.representation = [
        ['1', '2', '3'],
        ['4', '5', '6'],
        ['7', '8', '9'],
      ];
      if (playersValue[game.turn] == '\u001b[33mO') {
        this.changeTurn();
      }
    } else if (input == 2) {
      matchFlag = quit();
    }
  }

  bool quit() {
    print('');
    print(
        '\u001b[37mJogador \u001b[32mX \u001b[37mfez ${players[0].score} ponto(s)');
    print(
        '\u001b[37mJogador \u001b[33mO \u001b[37mfez ${players[1].score} ponto(s)');
    print('\u001b[37mO jogo foi encerrado!');
    return false;
  }

  void end() {
    board.render(board.representation);
    if (playersValue[game.turn] == '\u001b[32mX' ||
        playersValue[game.turn] == '\u001b[33mO') {
      players[game.turn].score += 1;

      return;
    }
  }
}
