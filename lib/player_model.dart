import 'dart:io';

// 캐릭터 정보 클래스 생성
// ㄴ 캐릭터 정보(이름, 체력, 공격력, 방어력) txt 파일에서 추출
//    ㄴ
// ㄴ 공격 메서드, 방어 메서드, 상태(체력, 공격력, 방어력) 메서드

class PlayerModel {
  final String inputName;
  int hp;
  int power;
  int shield;
  PlayerModel(this.inputName, this.hp, this.power, this.shield);

  void show() {
    print("$inputName - 체력: $hp, 공격력: $power, 방어력: $shield");
  }
}
