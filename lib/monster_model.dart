import 'dart:io';
import 'dart:math';
import 'package:battle_rpg/unit_model.dart';

// 몬스터 정보 클래스 생성
// ㄴ 몬스터 정보(이름, 체력, 공격력(공격력 >= 플레이어 방어), 방어력(0)) txt 파일에서 추출
// ㄴ 공격 메서드, 체력 상태(체력, 공격력, 방어력) 메서드

class MonsterModel extends Unit {
  MonsterModel(String name, int hp, int power, int shield)
    : super(name, hp, power, shield);

  static List<MonsterModel> monsterStatsLoad(int playerShield) {
    List<MonsterModel> monsterList = [];
    final monsterFile = File('assets/monsters.txt');
    final lines = monsterFile.readAsLinesSync();
    for (var line in lines) {
      var mParts = line.split(",");
      String monsterName = mParts[0];
      int monsterHp = int.tryParse(mParts[1]) ?? 0;
      int maxPower = int.tryParse(mParts[2]) ?? 0;
      int monsterShield = int.tryParse(mParts[3]) ?? 0;
      int monsterDamage =
          Random().nextInt(maxPower) +
          (playerShield + 1); // 공격력 랜덤값으로 들어가게 변경 완료
      monsterList.add(
        MonsterModel(monsterName, monsterHp, monsterDamage, monsterShield),
      );
    }
    return monsterList;
  } // 몬스터 리스트 스탯 정보
}
