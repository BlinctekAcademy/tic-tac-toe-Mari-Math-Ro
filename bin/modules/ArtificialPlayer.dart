import 'Player.dart' show Player;
import 'Board.dart' show Board;
import 'dart:io';

class ArtificialPlayer extends Player {
  List<List<int>> scoreBoard;
  Board board = Board();

  ArtificialPlayer(String _value, int _score) : super(_value, _score);

  void go() {}

  void play() {
    stdout.write(
        '\u001b[37mJogador \u001b[32mX\u001b[37m, faça sua jogada (Pressione 0 para fechar o jogo): ');
    int playerXFieldInput = int.tryParse(stdin.readLineSync());
  }

  void calculateBestMove(turn) {
    int bestScore = -1000;
    List<int> bestMove = [-1, -1];
    String tempCoord = '';
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (this.board.representation[i][j] != '\u001b[32mX' &&
            this.board.representation[i][j] != '\u001b[33mO') {
          tempCoord = this.board.representation[i][j];
          this.board.representation[i][j] = '\u001b[33mO';
          int score = minimax(0);
          this.board.representation[i][j] = tempCoord;
          if (score > bestScore) {
            bestScore = score;
            bestMove = [i, j];
          }
        }
      }
      ;
    }
    this.board.representation = board.writePlayersSymbolAtField(
        coordinate: bestMove, symbol: '\u001b[33mO');
    turn = 0;
  }

  int minimax(turn) {
    if (this.board.checkWin() && turn == 0) {
      return -1;
    }
    if (this.board.checkWin() && turn == 1) {
      return 1;
    }
    if (this.board.checkTie() && !this.board.checkWin()) {
      return 0;
    }
    if (turn == 1) {
      int bestScore = -1000;
      String tempCoord = '';
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (this.board.representation[i][j] != '\u001b[32mX' &&
              this.board.representation[i][j] != '\u001b[33mO') {
            tempCoord = this.board.representation[i][j];
            this.board.representation[i][j] = '\u001b[33mO';
            int score = minimax(0);
            this.board.representation[i][j] = tempCoord;
            if (score > bestScore) {
              bestScore = score;
            }
          }
        }
      }
      return bestScore;
    }
    int bestScore = 1000;
    String tempCoord = '';
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (this.board.representation[i][j] != '\u001b[32mX' &&
            this.board.representation[i][j] != '\u001b[33mO') {
          tempCoord = this.board.representation[i][j];
          this.board.representation[i][j] = '\u001b[32mX';
          int score = minimax(1);
          this.board.representation[i][j] = tempCoord;
          if (score < bestScore) {
            bestScore = score;
          }
        }
      }
    }
    return bestScore;
  }
}
