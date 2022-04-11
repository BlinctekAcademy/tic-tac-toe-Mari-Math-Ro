//Prints the map/array with the tic tac toe's grid
void print_map(List map) {
  var line_count = 0;
  print('');
  for (var i = 0; i < 5; i++) {
    if ((i + 1) % 2 != 0) {
      print(
          '\u001b[34m ${map[line_count][0]} | ${map[line_count][1]} | ${map[line_count][2]} ');
      line_count += 1;
    } else {
      print('\u001b[34m---|---|---');
    }
  }
  print('');
}

// Receives an 1 - 9 number as input and returns a map's coordinate
// ignore: missing_return
List num_to_xy(chose_num) {
  if (chose_num == 1) {
    return [0, 0];
  } else if (chose_num == 2) {
    return [0, 1];
  } else if (chose_num == 3) {
    return [0, 2];
  } else if (chose_num == 4) {
    return [1, 0];
  } else if (chose_num == 5) {
    return [1, 1];
  } else if (chose_num == 6) {
    return [1, 2];
  } else if (chose_num == 7) {
    return [2, 0];
  } else if (chose_num == 8) {
    return [2, 1];
  } else if (chose_num == 9) {
    return [2, 2];
  }
}

//Writes the player's symbol on the chose map's coordinate
List<List> write_map(List<List<String>> map, String symbol, List coordinate) {
  map[coordinate[0]][coordinate[1]] = symbol;
  return map;
}

//Checks if the selected coordinate is actually available
bool check_availability(map, coordinate) {
  if (map[coordinate[0]][coordinate[1]] == 'X' ||
      map[coordinate[0]][coordinate[1]] == 'O') {
    return false;
  } else {
    return true;
  }
}

//Checks if the player's input is valid
// ignore: missing_return
bool check_validity(player_input) {
  if (player_input is! int) {
    return false;
  } else if ((player_input < 1) | (player_input > 9)) {
    return false;
  }
}

//Change turns
int change_turn(int turn) {
  if (turn == 1) {
    return 0;
  } else {
    return 1;
  }
}

//Checks if the player which is actually playing won after his turn
bool horizontal_check(map, flag) {
  for (var i = 0; i < 3; i++) {
    if ((map[i][0] == map[i][1]) & (map[i][1] == map[i][2])) {
      flag = false;
    }
  }
  return flag;
}

bool vertical_check(map, flag) {
  for (var i = 0; i < 3; i++) {
    if ((map[0][i] == map[1][i]) & (map[1][i] == map[2][i])) {
      flag = false;
    }
  }
  return flag;
}

bool diagonal_check(map, flag) {
  if ((map[0][0] == map[1][1]) & (map[1][1] == map[2][2])) {
    flag = false;
    return flag;
  } else if ((map[0][2] == map[1][1]) & (map[1][1] == map[2][0])) {
    flag = false;
    return flag;
  } else {
    return true;
  }
}

// ignore: missing_return
bool check_tie(map, flag) {
  var countFreeHouses = 0;
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if ((map[i][j] != 'X') & (map[i][j] != 'O')) {
        countFreeHouses += 1;
      }
    }
  }
  if ((countFreeHouses == 0) & (flag == true)) {
    return true;
  } else {
    return false;
  }
}
