import 'dart:io';
import 'Board.dart' show Board;
import 'Player.dart' show Player;

class Game {
  Player player = Player('X', 1); //Parâmetros ainda serão implementados
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
  }

  bool isModeValid() {
    return this.board.validateGameMode(this.mode);
  }

  void start() {
    print('object');
  }

  void play(field) {}

  //Change turns
  void changeTurn() {
    turn = turn == 1 ? 0 : 1;
  }

//receber o valor do input de restart, if == 1, chame start(), if == 2, chame quit()
  int restart() {
    stdout
        .write('deseja jogar outra partida? (Digite 1 para Sim e 2 para Não ');

    return int.tryParse(stdin.readLineSync());
  }

  bool quit() {
    print('\u001b[37mO jogo foi encerrado!');
    return false;
  }
}
