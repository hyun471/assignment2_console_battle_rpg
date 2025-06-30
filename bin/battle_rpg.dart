import 'dart:io';
import 'package:battle_rpg/battle_rpg.dart';
import 'package:battle_rpg/player_model.dart';

void main() {
  print("");
  print("Battle RPG에 오신걸 환영합니다!");
  print("");
  stdout.write("캐릭터의 이름을 입력하세요: ");
  String? inputName = stdin.readLineSync() ?? "";
  BattleStart rpgRun = BattleStart();
  rpgRun.showPlayer(inputName);
  print("");
}
// 캐릭터 정보 클래스 생성
// ㄴ 캐릭터 정보(이름, 체력, 공격력, 방어력) 파일에서 추출
// ㄴ 공격 메서드, 방어 메서드, 상태(체력, 공격력, 방어력) 메서드

// 몬스터 정보 클래스 생성
// ㄴ 몬스터 정보(이름, 체력, 공격력(공격력 >= 플레이어 방어), 방어력(0)) 파일에서 추출
// ㄴ 공격 메서드, 체력 상태(체력, 공격력, 방어력) 메서드

// 게임 시작 클래스 생성
// ㄴ 캐릭터, 몬스터, 라운드(물리친 몬스터 수)
// ㄴ 게임시작 메서드, 전투 진행 메서드, 랜덤 몬스터 불러오기 메서드
