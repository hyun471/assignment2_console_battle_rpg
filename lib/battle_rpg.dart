import 'dart:io';
import 'dart:math';
import 'package:battle_rpg/monster_model.dart';
import 'package:battle_rpg/player_model.dart';
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
class BattleStart {
  List<MonsterModel> monsterList = [];
  PlayerModel? player;
  int killMoster = 0;
  bool continueCheck = true;

  void showPlayer(String inputName) {
    final playerFile = File('assets/characters.txt');
    final pLine = playerFile.readAsLinesSync()[0];
    final pPart = pLine.split(",");
    String playerName = inputName;
    int playerHp = int.parse(pPart[0]);
    int playerPower = int.parse(pPart[1]);
    int playerShield = int.parse(pPart[2]);
    player = PlayerModel(playerName, playerHp, playerPower, playerShield);
    player?.show();
  } // 플레이어 정보

  void saveMonster() {
    final monsterFile = File('assets/monsters.txt');
    final lines = monsterFile.readAsLinesSync();
    // 불러온 파일은 몬스터의 최대 공격력이고 랜덤값이 들어가게 변경해야함
    for (var line in lines) {
      var parts = line.split(",");
      String monsterName1 = parts[0];
      int monsterHp1 = int.parse(parts[1]);
      int maxPower1 = int.parse(parts[2]);
      int monsterDamage = Random().nextInt(maxPower1) + (player!.shield + 1);
      monsterList.add(MonsterModel(monsterName1, monsterHp1, monsterDamage));
    }
  } // 몬스터 정보

  // 추상 클래스로 다시 구성하는거 생각해보기
  void battleStart() {
    if (player == null) {
      return;
    }
    final random = Random();
    int index = random.nextInt(monsterList.length);
    MonsterModel selectedMonster = monsterList[index];
    int round = 1;
    print("몬스터 ${selectedMonster.monsterName}(이)가 출현했습니다.");
    if (player!.hp != 0) {
      continueCheck == true;
    } else if (player!.hp == 0) {
      continueCheck == false;
    }
    while (continueCheck) {
      selectedMonster.monsterShow();
      player?.show(); // 상태 표시
      print("");
      print("$round round");
      if (player!.hp != 0) {
        print("");
        print("${player!.inputName}의 턴");
        stdout.write("행동을 선택하세요. (1: 공격, 2: 방어) : ");
        String? playerAction = stdin.readLineSync() ?? "";
        switch (playerAction) {
          case "1":
            selectedMonster.monsterHp -= player!.power;
            print(
              "${player!.inputName}(이)가 ${selectedMonster.monsterName}에게 ${player!.power}의 데미지를 입혔습니다.",
            );
            if (selectedMonster.monsterHp <= 0) {
              continueCheck = false;
            } // 플레이어 공격
            break;
          case "2":
            int heal = 50 - player!.hp;
            if (heal > 6) {
              print(
                "${player!.inputName}(이)가 방어 태세를 취하여 ${player!.shield} 만큼 체력을 얻었습니다.",
              );
              player!.hp += player!.shield;
            } else if (heal < 6) {
              print("${player!.inputName}(이)가 방어 태세를 취하여 $heal 만큼 체력을 얻었습니다.");
              player!.hp += heal;
            }
            break; // 플레이어 방어
        }
        if (continueCheck == true) {
          print("");
          print("${selectedMonster.monsterName}의 턴");
          int realDamages = selectedMonster.monsterPower - player!.shield;
          player!.hp -= realDamages;
          if (player!.hp <= 0) {
            player!.hp = 0;
          }
          print(
            "${selectedMonster.monsterName}(이)가 ${player!.inputName}에게 $realDamages를 입혔습니다.",
          ); // 몬스터 공격
          round += 1;
        }
      } else if (player!.hp == 0) {
        print("");
        print("Game Over");
        continueCheck = false;
        stdout.write("결과를 저장하시겠습니까? ( y / n ) : ");
        String? result1 = stdin.readLineSync() ?? "";
        if (result1.toLowerCase() == "y") {
          final result = File('assets/result.txt');
          final saveResult = result.writeAsStringSync(
            "${player!.inputName} - 남은 체력 : ${player!.hp}, 처치한 몬스터 수 : ${killMoster}",
          );
          print("");
          print("저장되었습니다.");
        } else {
          return;
        }
      } // 저장
    } // 배틀
    killMoster += 1;
    print("");
    print("축하합니다. 몬스터 ${selectedMonster.monsterName}(을)를 물리쳤습니다.");
    print("");
    stdout.write("다음 몬스터와 싸우시겠습니까? ( y / n ) : ");
    String? battleContinue = stdin.readLineSync() ?? "";
    if (battleContinue.toLowerCase() == "n") {
      stdout.write("결과를 저장하시겠습니까? ( y / n ) : ");
      String? result2 = stdin.readLineSync() ?? "";
      if (result2.toLowerCase() == "y") {
        final result = File('assets/result.txt');
        final saveResult = result.writeAsStringSync(
          "${player!.inputName} - 남은 체력 : ${player!.hp}, 처치한 몬스터 수 : ${killMoster}",
        );
        print("저장되었습니다.");
        continueCheck = false;
      } else if (result2.toLowerCase() == "n") {
        print("게임을 종료합니다.");
        continueCheck = false;
      }
    } else if (battleContinue.toLowerCase() == "y") {
      continueCheck = true;
    }
  } // 배틀 메서드
}
