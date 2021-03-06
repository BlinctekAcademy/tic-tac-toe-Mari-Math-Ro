import '../desafio_blinctek.dart';
import 'dart:io';

class Board {
  List<List<String>> _representation = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
  ];

  List<List<String>> get representation {
    return this._representation;
  }

  set representation(List<List<String>> representation) {
    this._representation = representation;
  }

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

  void render() {
    int lineCount = 0;
    print('');
    for (int i = 0; i < 5; i++) {
      if ((i + 1) % 2 != 0) {
        print(
            '\u001b[36m ${this._representation[lineCount][0]} \u001b[31m|\u001b[36m ${this._representation[lineCount][1]} \u001b[31m|\u001b[36m ${this._representation[lineCount][2]} ');
        lineCount += 1;
      } else {
        print('\u001b[31m---|---|---');
      }
    }
    print('');
  }

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
    this.render();
    print('');
    stdout.write('\u001b[31mEscolha um valor válido: ');
    game.playerInputValue = int.tryParse(stdin.readLineSync());
    isValid = this.validatePlayerInput(game.playerInputValue);

    invalidInputHandler(isValid);
  }

  int invalidRestartInputHandler(isValid, [lastInput]) {
    if (isValid) return lastInput;
    this.render();
    print('');
    stdout.write('\u001b[31mEscolha um valor válido: ');
    game.playerInputValue = int.tryParse(stdin.readLineSync());
    isValid = this.validateRestartInput(game.playerInputValue);

    invalidRestartInputHandler(isValid, game.playerInputValue);

    return game.playerInputValue;
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
    return !(this._representation[coordinate[0]][coordinate[1]] ==
            '\u001b[32mX' ||
        this._representation[coordinate[0]][coordinate[1]] == '\u001b[33mO');
  }

  //Writes the player's symbol on the chose board's coordinate
  void writePlayersSymbolAtField({List coordinate, String symbol}) {
    this._representation[coordinate[0]][coordinate[1]] = symbol;
  }

  //Checks if the player which is actually playing won after his turn
  bool checkHorizontalWinning() {
    for (int i = 0; i < 3; i++) {
      if ((this._representation[i][0] == this._representation[i][1]) &
          (this._representation[i][1] == this._representation[i][2])) {
        return true;
      }
    }
    return false;
  }

  bool checkVerticalWinning() {
    for (int i = 0; i < 3; i++) {
      if ((this._representation[0][i] == this._representation[1][i]) &
          (this._representation[1][i] == this._representation[2][i])) {
        return true;
      }
    }
    return false;
  }

  bool checkDiagonalWinning() {
    if ((this._representation[0][0] == this._representation[1][1]) &
        (this._representation[1][1] == this._representation[2][2])) {
      return true;
    }
    if ((this._representation[0][2] == this._representation[1][1]) &
        (this._representation[1][1] == this._representation[2][0])) {
      return true;
    }
    return false;
  }

  bool checkTie() {
    int freeHouses = 9;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if ((this._representation[i][j] == '\u001b[32mX') |
            (this._representation[i][j] == '\u001b[33mO')) {
          freeHouses -= 1;
        }
      }
    }
    return (freeHouses == 0);
  }

  bool checkWin() {
    if (this.checkDiagonalWinning()) return true;
    if (this.checkHorizontalWinning()) return true;
    if (this.checkVerticalWinning()) return true;

    return false;
  }
}
