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
  List<int> monsterAction = [1, 2];
  PlayerModel? player;

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
  }

  void saveMonster() {
    final monsterFile = File('assets/monsters.txt');
    final lines = monsterFile.readAsLinesSync();

    for (var line in lines) {
      var parts = line.split(",");
      String monsterName1 = parts[0];
      int monsterHp1 = int.parse(parts[1]);
      int monsterPower1 = int.parse(parts[2]);
      monsterList.add(MonsterModel(monsterName1, monsterHp1, monsterPower1));
    }
  }

  void battleStart() {
    if (player == null) {
      return;
    }
    final random = Random();
    int index = random.nextInt(monsterList.length);
    MonsterModel selectedMonster = monsterList[index];
    int round = 1;
    print("$round round");
    print("몬스터 ${selectedMonster.monsterName}(이)가 출현했습니다.");
    selectedMonster.monsterShow();
    while (selectedMonster.monsterHp == 0) {
      if (player!.hp != 0) {
        print("${player!.inputName}의 턴");
        stdout.write("행동을 선택하세요. (1: 공격, 2: 방어)");
        String? playerAction = stdin.readLineSync() ?? "";
        switch (playerAction) {
          case "1":
            break;
          case "2":
            break;
        }
      } else if (player!.hp == 0) {
        print("Game Over");
        print("결과를 저장하시겠습니까?");
      }
    }
    print("축하합니다. 몬스터 ${selectedMonster.monsterName}(을)를 물리쳤습니다.");
    print("결과를 저장하시겠습니까?");
  }
}
