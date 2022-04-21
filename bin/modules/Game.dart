import 'dart:io';
import '../desafio_blinctek.dart';
import 'Board.dart' show Board;
import 'Player.dart' show Player;
import 'HumanPlayer.dart' show HumanPlayer;
import 'ArtificialPlayer.dart' show ArtificialPlayer;

class Game {
  HumanPlayer _humanPlayer = HumanPlayer('\u001b[32mX', 0);
  ArtificialPlayer _artificialPlayer = ArtificialPlayer('\u001b[33mO', 0);
  List<Player> _players;
  Board _board = Board();
  int _turn = 0;
  int _mode;
  int _playerInputValue;
  bool _moveFlag = true;
  bool _matchFlag = true;
  bool _isInputValid = true;

  HumanPlayer get humanPlayer {
    return this._humanPlayer;
  }

  set humanPlayer(HumanPlayer humanPlayer) {
    this._humanPlayer = humanPlayer;
  }

  ArtificialPlayer get artificialPlayer {
    return this._artificialPlayer;
  }

  set artificialPlayer(ArtificialPlayer artificialPlayer) {
    this._artificialPlayer = artificialPlayer;
  }

  int get turn {
    return this._turn;
  }

  set turn(int turn) {
    this._turn = turn;
  }

  int get mode {
    return this._mode;
  }

  set mode(int mode) {
    this._mode = mode;
  }

  int get playerInputValue {
    return this._playerInputValue;
  }

  set playerInputValue(int playerInputValue) {
    this._playerInputValue = playerInputValue;
  }

  bool get moveFlag {
    return this._moveFlag;
  }

  set moveFlag(bool moveFlag) {
    this._moveFlag = moveFlag;
  }

  bool get matchFlag {
    return this._matchFlag;
  }

  set matchFlag(bool matchFlag) {
    this._matchFlag = matchFlag;
  }

  bool get isInputValid {
    return this._isInputValid;
  }

  set isInputValid(bool isInputValid) {
    this._isInputValid = isInputValid;
  }

  Game() {
    _players = [_humanPlayer, _artificialPlayer];
  }

  void welcome() {
    print('Seja bem vindo ao Jogo da Velha!');
  }

  void chooseMode() {
    stdout.write(
        'Você deseja jogar contra um amigo ou a CPU? (Digite 1 para amigo e 2 para CPU): ');
    this.mode = int.tryParse(stdin.readLineSync());

    while (!game.isModeValid()) {
      print('');
      stdout.write('\u001b[31mEscolha um modo de jogo válido: ');
      game.mode = int.tryParse(stdin.readLineSync());
    }
    isModeValid();
  }

  bool isModeValid() {
    return this._board.validateGameMode(this.mode);
  }

  void start() {
    this._board.render();
    if (this.mode == 1) {
      this.play();
    } else if (this.mode == 2) {
      if (turn == 0) {
        this.play();
      } else {
        List<int> bestMove =
            artificialPlayer.calculateBestMove(this._board, this._turn);

        this._board.writePlayersSymbolAtField(
            coordinate: bestMove, symbol: '\u001b[33mO');
      }
    }
    _isInputValid = _board.validatePlayerInput(_playerInputValue);
  }

  void play() {
    stdout.write(
        '\u001b[37mJogador ${_players[game.turn].value}\u001b[37m, faça sua jogada (Pressione 0 para fechar o jogo): ');

    _playerInputValue = humanPlayer.getMove();
  }

  void goHuman() {
    while (_matchFlag) {
      while (_moveFlag) {
        this.start();

        //fluid interface
        print('\x1B[2J\x1B[0;0H');

        //Exit Game
        if (_playerInputValue == 0) {
          game.quit();
          return;
        }

        _board.invalidInputHandler(_isInputValid);

        List<int> chosenCoordinate = _board.numToCoordinate(_playerInputValue);

        _board.isFieldAvailable(chosenCoordinate);

        while (!_board.isFieldAvailable(chosenCoordinate)) {
          print('');
          _board.render();
          stdout.write('\u001b[31mEscolha uma casa livre: ');
          _playerInputValue = int.tryParse(stdin.readLineSync());
          _isInputValid = _board.validatePlayerInput(_playerInputValue);

          _board.invalidInputHandler(_isInputValid);

          chosenCoordinate = _board.numToCoordinate(_playerInputValue);
        }

        _board.writePlayersSymbolAtField(
            coordinate: chosenCoordinate,
            symbol: '${_players[game.turn].value}');

        if (_board.checkWin()) {
          print(
              '\n\u001b[37mO jogador \u001b[32m${_players[game.turn].value} \u001b[37mganhou!');
          break;
        }

        if (_board.checkTie()) {
          _board.render();
          print('\x1B[33mO jogo empatou!');
          break;
        }

        game.changeTurn();

        //fluid interface
        print('\x1B[2J\x1B[0;0H');
      }

      this.end();
      stdout.write(
          '\u001b[37mDeseja jogar outra partida? (Digite 1 para Sim e 2 para Não): ');
      int restartInput = int.tryParse(stdin.readLineSync());
      this.restart(restartInput);
    }
  }

  void goAi() {
    while (this._matchFlag) {
      while (this._moveFlag) {
        this.start();
        print('\x1B[2J\x1B[0;0H');

        if (turn == 0) {
          if (_playerInputValue == 0) {
            game.quit();
            return;
          }

          _board.invalidInputHandler(_isInputValid);

          List<int> chosenCoordinate =
              _board.numToCoordinate(_playerInputValue);

          while (!_board.isFieldAvailable(chosenCoordinate)) {
            print('');
            _board.render();
            stdout.write('\u001b[31mEscolha uma casa livre: ');
            _playerInputValue = int.tryParse(stdin.readLineSync());
            _isInputValid = _board.validatePlayerInput(_playerInputValue);

            _board.invalidInputHandler(_isInputValid);

            chosenCoordinate = _board.numToCoordinate(_playerInputValue);
          }

          _board.writePlayersSymbolAtField(
              coordinate: chosenCoordinate,
              symbol: '${_players[game.turn].value}');
        }
        if (_board.checkWin()) {
          print(
              '\n\u001b[37mO jogador \u001b[32m${_players[game.turn].value} \u001b[37mganhou!');
          break;
        }

        if (_board.checkTie()) {
          _board.render();
          print('\x1B[33mO jogo empatou!');
          break;
        }

        game.changeTurn();

        //fluid interface
        print('\x1B[2J\x1B[0;0H');
      }

      this.end();
      stdout.write(
          '\u001b[37mDeseja jogar outra partida? (Digite 1 para Sim e 2 para Não): ');
      int restartInput = int.tryParse(stdin.readLineSync());
      this.restart(restartInput);
    }
  }

  void changeTurn() {
    turn = turn == 1 ? 0 : 1;
  }

  void restart(input) {
    input = _board.invalidRestartInputHandler(
        _board.validateRestartInput(input), input);
    if (input == 1) {
      _moveFlag = true;
      _matchFlag = true;
      _board.representation = [
        ['1', '2', '3'],
        ['4', '5', '6'],
        ['7', '8', '9'],
      ];
      if (_players[game.turn].value == '\u001b[33mO') {
        this.changeTurn();
      }
    } else if (input == 2) {
      _matchFlag = quit();
    }
  }

  bool quit() {
    print('');
    print(
        '\u001b[37mJogador \u001b[32mX \u001b[37mfez ${_players[0].score} ponto(s)');
    print(
        '\u001b[37mJogador \u001b[33mO \u001b[37mfez ${_players[1].score} ponto(s)');
    print('\u001b[37mO jogo foi encerrado!');
    return false;
  }

  void end() {
    if (_board.checkTie()) return;
    _board.render();
    if (_players[game.turn].value == '\u001b[32mX' ||
        _players[game.turn].value == '\u001b[33mO') {
      _players[game.turn].score += 1;

      return;
    }
  }
}
