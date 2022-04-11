class Board {
  List<List<String>> representation = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
  ];

  Board();

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
}


/*[['1', '2', '3'], ['4', '5', '6'],['7', '8', '9']]


*/