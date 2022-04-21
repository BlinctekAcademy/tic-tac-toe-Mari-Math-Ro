import './modules/Game.dart' show Game;

Game game = Game();

void main(List<String> arguments) {
  //fluid interface
  print('\x1B[2J\x1B[0;0H');

  game.welcome();
  game.chooseMode();

  if (game.mode == 1) {
    game.goHuman();
  } else if (game.mode == 2) {
    game.goAi();
  }
}
