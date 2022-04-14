import '../desafio_blinctek.dart';
import 'dart:io';
import 'Player.dart';

class Board {
  List<List<String>> representation = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
  ];

  Board();

  bool validateGameMode(playerInput) {
    if (playerInput is! int) {
      return false;
    }
    if ((playerInput != 1) & (playerInput != 2)) {
      return false;
    }
    return true;
  }

  void render(List board) {
    int lineCount = 0;
    print('');
    for (int i = 0; i < 5; i++) {
      if ((i + 1) % 2 != 0) {
        print(
            '\u001b[36m ${board[lineCount][0]} \u001b[31m|\u001b[36m ${board[lineCount][1]} \u001b[31m|\u001b[36m ${board[lineCount][2]} ');
        lineCount += 1;
      } else {
        print('\u001b[31m---|---|---');
      }
    }
    print('');
  }

  //Checks if the player's input is valid
  bool validatePlayerInput(playerInput) {
    if (playerInput is! int) {
      return false;
    }
    return (playerInput >= 1) & (playerInput <= 9);
  }

  bool validateRestartInput(playerInput) {
    if (playerInput is! int) {
      return false;
    }
    return (playerInput == 1) | (playerInput == 2);
  }

  void invalidInputHandler(isValid) {
    if (isValid) return;
    print('');
    stdout.write('\u001b[31mEscolha um valor válido: ');
    playerInputValue = int.tryParse(stdin.readLineSync());
    isValid = board.validatePlayerInput(playerInputValue);

    invalidInputHandler(isValid);
  }

  int invalidRestartInputHandler(isValid, [lastInput]) {
    if (isValid) return lastInput;
    print('');
    stdout.write('\u001b[31mEscolha um valorr válido: ');
    playerInputValue = int.tryParse(stdin.readLineSync());
    isValid = board.validateRestartInput(playerInputValue);

    invalidRestartInputHandler(isValid, playerInputValue);

    return playerInputValue;
  }

  // Receives an 1 - 9 number as input and returns a board's coordinate
  List<int> numToCoordinate(chosenNum) {
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
    return [-1, -1];
  }

  //Checks if the selected coordinate is actually available
  bool isFieldAvailable(List coordinate) {
    return !(this.representation[coordinate[0]][coordinate[1]] ==
            '\u001b[32mX' ||
        this.representation[coordinate[0]][coordinate[1]] == '\u001b[33mO');
  }

  //Writes the player's symbol on the chose board's coordinate
  List<List> writePlayersSymbolAtField({List coordinate, String symbol}) {
    this.representation[coordinate[0]][coordinate[1]] = symbol;
    return this.representation;
  }

  //Checks if the player which is actually playing won after his turn
  bool checkHorizontalWinning(flag) {
    for (int i = 0; i < 3; i++) {
      if ((this.representation[i][0] == this.representation[i][1]) &
          (this.representation[i][1] == this.representation[i][2])) {
        flag = false;
      }
    }
    return flag;
  }

  bool checkVerticalWinning(flag) {
    for (int i = 0; i < 3; i++) {
      if ((this.representation[0][i] == this.representation[1][i]) &
          (this.representation[1][i] == this.representation[2][i])) {
        flag = false;
      }
    }
    return flag;
  }

  bool checkDiagonalWinning(flag) {
    if ((this.representation[0][0] == this.representation[1][1]) &
        (this.representation[1][1] == this.representation[2][2])) {
      flag = false;
      return flag;
    }
    if ((this.representation[0][2] == this.representation[1][1]) &
        (this.representation[1][1] == this.representation[2][0])) {
      flag = false;
      return flag;
    }
    return true;
  }

  bool checkTie() {
    int countFreeHouses = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if ((this.representation[i][j] != '\u001b[32mX') &
            (this.representation[i][j] != '\u001b[33mO')) {
          countFreeHouses += 1;
        }
      }
    }
    return (countFreeHouses == 0);
  }
}
