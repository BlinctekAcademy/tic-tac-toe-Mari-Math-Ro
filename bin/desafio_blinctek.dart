import 'module.dart' as module;
import 'dart:io';

//Map
List<List<String>> map = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9'],
];

const playerOne = 'X';
const playerTwo = 'O';
var players = [playerOne, playerTwo];
int turn = 0;
var choseCoordinate = [];
var playerInput = 0;
bool flag = true;
bool ifAvailable = true;
bool ifValid = true;
String finalMessage = '\n\u001b[32mO jogador ${players[turn]} ganhou!';

void main(List<String> arguments) {
  print('\x1B[2J\x1B[0;0H');
  while (flag == true) {
    module.print_map(map);

    stdout.write('\u001b[32mJogador ${players[turn]}, faça sua jogada: ');
    playerInput = int.tryParse(stdin.readLineSync());

    ifValid = module.check_validity(playerInput);

    //LEMBRETE: TRANSFORMAR EM FUNÇÃO
    if (ifValid == false) {
      while (ifValid == false) {
        print('');
        stdout.write('\u001b[32mEscolha um valor válido: ');
        playerInput = int.tryParse(stdin.readLineSync());
        ifValid = module.check_validity(playerInput);
      }
    }

    choseCoordinate = module.num_to_xy(playerInput);

    ifAvailable = module.check_availability(map, choseCoordinate);

    if (ifAvailable == false) {
      while (ifAvailable == false) {
        print(' ');
        stdout.write('\u001b[32mEscolha uma casa livre: ');
        playerInput = int.tryParse(stdin.readLineSync());
        ifValid = module.check_validity(playerInput);

        //CHAMAR FUNÇÃO A SER CRIADA
        if (ifValid == false) {
          while (ifValid == false) {
            print('');
            stdout.write('\u001b[32mEscolha um valor válido: ');
            playerInput = int.tryParse(stdin.readLineSync());
            ifValid = module.check_validity(playerInput);
          }
        }

        //Segue o código
        choseCoordinate = module.num_to_xy(playerInput);
        ifAvailable = module.check_availability(map, choseCoordinate);
      }
    }

    module.write_map(map, players[turn], choseCoordinate);

    if (flag == true) {
      flag = module.horizontal_check(map, flag);
    }

    if (flag == true) {
      flag = module.vertical_check(map, flag);
    }

    if (flag == true) {
      flag = module.diagonal_check(map, flag);
    }

    if (module.check_tie(map, flag) == true) {
      finalMessage = '\n\u001b[32mO jogo empatou!';
      flag = false;
    }

    if (flag == true) {
      turn = module.change_turn(turn);
    }

    print('\x1B[2J\x1B[0;0H');
  }

  module.print_map(map);
  print(finalMessage);
}
