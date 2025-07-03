import 'dart:io';
import 'dart:math';
import 'package:battle_rpg/monster_model.dart';
import 'package:battle_rpg/player_model.dart';
import 'package:battle_rpg/unit_model.dart';
// 게임 시작 클래스 생성
// ㄴ 캐릭터, 몬스터, 라운드(물리친 몬스터 수)
//    ㄴ 캐릭터 정보 입력은 정규표현식을 활용하자.
// ㄴ 게임시작 메서드, 전투 진행 메서드, 랜덤 몬스터 불러오기 메서드

// 게임 종료
// ㄴ 캐릭터의 남은 체력이 0이 될 경우 Game Over 와 함께 저장여부 확인
// ㄴ 한 라운드가 끝나고 저장 여부 확인
// ㄴ 저장 시 캐릭터 이름, 남은 체력, 게임 결과(승리/패패), 최대 라운드 내용 저장

// 캐릭터와 몬스터의 공통된 부분을 추상화 하여 추상 클래스 구현
// ㄴ공격 기능
class BattleRPG {
  PlayerModel? player;
  MonsterModel? monster;
  int killMonster = 0;
  bool continueCheck = true;
  int round = 1;

  BattleRPG(this.player);

  void gameStart() {
    print("");
    print("Battle RPG에 오신걸 환영합니다!");
    print("");
    stdout.write("캐릭터의 이름을 입력하세요 (영문만 가능) : ");
    String? inputName = stdin.readLineSync() ?? "";
    PlayerModel? player = PlayerModel.playerStatsLoad(inputName);
    player.show();
  } // 게임 첫 시작

  MonsterModel? monsterAppear(List<MonsterModel> monsterList) {
    if (player == null) {
      return null;
    }
    List<MonsterModel> aliveMonsterLists = monsterList
        .where((monster) => monster.hp > 0)
        .toList();
    final random = Random();
    if (aliveMonsterLists.isEmpty) {
      print("");
      print("모든 몬스터를 물리쳤습니다.");
      print("");
      gameSave();
      return null;
    } else {
      int index = random.nextInt(aliveMonsterLists.length);
      MonsterModel selectedMonster = aliveMonsterLists[index];
      print("");
      print("몬스터 ${selectedMonster.name}(이)가 출현했습니다.");
      return selectedMonster;
    }
  } // 몬스터 출현

  void gameSave() {
    stdout.write("결과를 저장하시겠습니까? ( y / n ) : ");
    continueCheck = false;
    String? result1 = stdin.readLineSync() ?? "n";
    if (result1.toLowerCase() == "y") {
      final result = File('assets/result.txt');
      final saveResult = result.writeAsStringSync(
        "${player!.name} - 남은 체력 : ${player!.hp}, 처치한 몬스터 수 : $killMonster",
      );
      print("");
      print("저장되었습니다.");
    } else if (result1.toLowerCase() == "n") {
      print("게임을 종료합니다.");
    }
  } // 결과 저장

  void battleStart(MonsterModel? selectedMonster) {
    if (selectedMonster == null) {
      print("모든 몬스터를 물리쳤습니다.");
      return;
    }
    if (player!.hp != 0) {
      continueCheck = true;
    } else if (player!.hp == 0) {
      continueCheck = false;
    }
    while (continueCheck) {
      selectedMonster.show();
      player?.show(); // 상태 표시
      print("");
      print("$round round");
      if (player!.hp != 0) {
        print("");
        print("${player!.name}의 턴");
        stdout.write("행동을 선택하세요. (1: 공격, 2: 방어) : ");
        String? playerAction = stdin.readLineSync() ?? "";
        switch (playerAction) {
          case "1":
            player?.attack(selectedMonster);
            if (selectedMonster.hp <= 0) {
              selectedMonster.hp = 0;
              continueCheck = false;
            } // 플레이어 공격
            break;
          case "2":
            player?.heal(player);
            break; // 플레이어 방어
        }
        if (continueCheck == true) {
          print("");
          print("${selectedMonster.name}의 턴");
          selectedMonster.attack(player as Unit);
          print("");
          if (player!.hp <= 0) {
            player!.hp = 0;
          }
          round += 1;
        }
      } else if (player!.hp == 0) {
        print("");
        print("Game Over");
        gameSave();
      } // 저장
    } // 배틀
    if (player!.hp == 0) {
      return;
    } else {
      killMonster += 1;
      print("");
      print("축하합니다. 몬스터 ${selectedMonster.name}(을)를 물리쳤습니다.");
      print("");
      stdout.write("다음 몬스터와 싸우시겠습니까? ( y / n ) : ");
      String? battleContinue = stdin.readLineSync() ?? "n";
      if (battleContinue.toLowerCase() == "n") {
        gameSave();
      } else if (battleContinue.toLowerCase() == "y") {
        continueCheck = true;
        round = 1;
      }
    }
  } // 배틀 메서드
}
