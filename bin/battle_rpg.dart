import 'package:battle_rpg/battle_rpg.dart';
import 'package:battle_rpg/monster_model.dart';
import 'package:battle_rpg/player_model.dart';

void main(dynamic player) {
  PlayerModel player = PlayerModel.playerStatsLoad("Player");
  BattleRPG rpgRun = BattleRPG(player);
  rpgRun.gameStart();
  List<MonsterModel> monsters = MonsterModel.monsterStatsLoad(player.shield);
  do {
    MonsterModel? selectedMonster = rpgRun.monsterAppear(monsters);
    if (selectedMonster == null) {
      return;
    }
    rpgRun.battleStart(selectedMonster);
  } while (rpgRun.continueCheck);
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
