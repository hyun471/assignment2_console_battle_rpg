// 몬스터 정보 클래스 생성
// ㄴ 몬스터 정보(이름, 체력, 공격력(공격력 >= 플레이어 방어), 방어력(0)) txt 파일에서 추출
// ㄴ 공격 메서드, 체력 상태(체력, 공격력, 방어력) 메서드
class MonsterModel {
  String monsterName;
  int monsterHp;
  int monsterPower;
  MonsterModel(this.monsterName, this.monsterHp, this.monsterPower);

  void monsterShow() {
    print("$monsterName - 체력: $monsterHp, 공격력: $monsterPower");
  }
}
