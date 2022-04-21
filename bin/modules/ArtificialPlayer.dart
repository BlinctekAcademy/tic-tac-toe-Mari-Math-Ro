import 'Player.dart' show Player;

class ArtificialPlayer extends Player {
  List<List<int>> scoreBoard;

  ArtificialPlayer(String _value, int _score) : super(_value, _score);

  List<int> calculateBestMove(board, turn) {
    int bestScore = -1000;
    List<int> bestMove = [-1, -1];
    String tempCoord = '';
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board.representation[i][j] != '\u001b[32mX' &&
            board.representation[i][j] != '\u001b[33mO') {
          tempCoord = board.representation[i][j];
          board.representation[i][j] = '\u001b[33mO';
          int score = minimax(board, 0);
          board.representation[i][j] = tempCoord;
          if (score > bestScore) {
            bestScore = score;
            bestMove = [i, j];
          }
        }
      }
    }
    return bestMove;
  }

  int minimax(board, turn) {
    int depth = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board.representation[i][j] != '\u001b[32mX' &&
            board.representation[i][j] != '\u001b[33mO') {
          depth += 1;
        }
      }
    }

    if (board.checkWin() && turn == 0) {
      return 1 + depth;
    }
    if (board.checkWin() && turn == 1) {
      return -(1 + depth);
    }
    if (board.checkTie() && !board.checkWin()) {
      return 0;
    }
    if (turn == 1) {
      int bestScore = -1000;
      String tempCoord = '';
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board.representation[i][j] != '\u001b[32mX' &&
              board.representation[i][j] != '\u001b[33mO') {
            tempCoord = board.representation[i][j];
            board.representation[i][j] = '\u001b[33mO';
            int score = minimax(board, 0);
            board.representation[i][j] = tempCoord;
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
        if (board.representation[i][j] != '\u001b[32mX' &&
            board.representation[i][j] != '\u001b[33mO') {
          tempCoord = board.representation[i][j];
          board.representation[i][j] = '\u001b[32mX';
          int score = minimax(board, 1);
          board.representation[i][j] = tempCoord;
          if (score < bestScore) {
            bestScore = score;
          }
        }
      }
    }
    return bestScore;
  }
}
