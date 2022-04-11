//Prints the board/array with the tic tac toe's grid

void printBoard(List board) {}

// Receives an 1 - 9 number as input and returns a board's coordinate
// ignore: missing_return
List numToCoordinate(chosenNum) {
  switch (chosenNum) {
    case 1:
      return [0, 0];
      break;
    case 2:
      return [0, 1];
      break;
    case 3:
      return [0, 2];
      break;
    case 4:
      return [1, 0];
      break;
    case 5:
      return [1, 1];
      break;
    case 6:
      return [1, 2];
      break;
    case 7:
      return [2, 0];
      break;
    case 8:
      return [2, 1];
      break;
    case 9:
      return [2, 2];
      break;
  }
}

//Writes the player's symbol on the chose board's coordinate
List<List> writePlayersSymbolAtField(
    {List<List<String>> board, List coordinate, String symbol}) {
  board[coordinate[0]][coordinate[1]] = symbol;
  return board;
}

//Checks if the selected coordinate is actually available
bool checkAvailability(List<List<String>> board, List coordinate) {
  if (board[coordinate[0]][coordinate[1]] == '\u001b[32mX' ||
      board[coordinate[0]][coordinate[1]] == '\u001b[33mO') {
    return false;
  } else {
    return true;
  }
}

//Checks if the player's input is valid
// ignore: missing_return
bool checkValidity(playerInput) {
  if (playerInput is! int) {
    return false;
  } else if ((playerInput < 1) | (playerInput > 9)) {
    return false;
  }
}

//Change turns
int changeTurn(int turn) {
  if (turn == 1) {
    return 0;
  } else {
    return 1;
  }
}

//Checks if the player which is actually playing won after his turn
bool horizontalCheck(board, flag) {
  for (int i = 0; i < 3; i++) {
    if ((board[i][0] == board[i][1]) & (board[i][1] == board[i][2])) {
      flag = false;
    }
  }
  return flag;
}

bool verticalCheck(board, flag) {
  for (int i = 0; i < 3; i++) {
    if ((board[0][i] == board[1][i]) & (board[1][i] == board[2][i])) {
      flag = false;
    }
  }
  return flag;
}

bool diagonalCheck(board, flag) {
  if ((board[0][0] == board[1][1]) & (board[1][1] == board[2][2])) {
    flag = false;
    return flag;
  } else if ((board[0][2] == board[1][1]) & (board[1][1] == board[2][0])) {
    flag = false;
    return flag;
  } else {
    return true;
  }
}

// ignore: missing_return
bool checkTie(board, flag) {
  int countFreeHouses = 0;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if ((board[i][j] != '\u001b[32mX') & (board[i][j] != '\u001b[33mO')) {
        countFreeHouses += 1;
      }
    }
  }
  return ((countFreeHouses == 0) & (flag));
}
