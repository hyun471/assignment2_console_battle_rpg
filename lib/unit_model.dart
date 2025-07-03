abstract class Unit {
  String name;
  int hp;
  int power;
  int shield;

  Unit(this.name, this.hp, this.power, this.shield);

  void show() {
    print("$name - 체력: $hp, 공격력: $power, 방어력: $shield");
  }

  void attack(Unit target) {
    target.hp -= (power - target.shield);
    print("$name(이)가 ${target.name}에게 ${power - target.shield}의 데미지를 입혔습니다.");
  }

  void heal(playerHp) {
    int heal = 50 - hp;
    if (heal >= 6) {
      print("$name(이)가 방어 태세를 취하여 $shield 만큼 체력을 얻었습니다.");
      hp += shield;
    } else if (heal < 6) {
      print("$name(이)가 방어 태세를 취하여 $heal 만큼 체력을 얻었습니다.");
      hp += heal;
    }
  }
}
