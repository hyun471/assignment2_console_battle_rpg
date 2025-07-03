import 'dart:io';
import 'package:battle_rpg/unit_model.dart';

// 캐릭터 정보 클래스 생성
// ㄴ 캐릭터 정보(이름, 체력, 공격력, 방어력) txt 파일에서 추출
//    ㄴ
// ㄴ 공격 메서드, 방어 메서드, 상태(체력, 공격력, 방어력) 메서드

class PlayerModel extends Unit {
  PlayerModel(String name, int hp, int power, int shield)
    : super(name, hp, power, shield);

  static PlayerModel playerStatsLoad(inputName) {
    final playerFile = File('assets/characters.txt');
    final pLine = playerFile.readAsLinesSync()[0];
    final pPart = pLine.split(",");
    String? playerName = inputName;
    int playerHp = int.tryParse(pPart[0]) ?? 0;
    int playerPower = int.tryParse(pPart[1]) ?? 0;
    int playerShield = int.tryParse(pPart[2]) ?? 0;
    return PlayerModel(inputName, playerHp, playerPower, playerShield);
  } // 플레이어 이름 및 스택 정보
}
