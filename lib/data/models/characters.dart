class Character {
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusIfDeadoralive;
  late List<dynamic> appearanceofSeasons;
  late String acotrName;
  late String categoryForTwoSeries;
  late List<dynamic> betterCallSaulAppearance;

  Character.from3son(Map<String, dynamic> json) {
    charId = json["charId"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statusIfDeadoralive = json["status"];
    appearanceofSeasons = json["apparance"];
    acotrName = json["portrayed"];
    categoryForTwoSeries = json["category"];
    betterCallSaulAppearance = json["better_call_saul_apperance"];
  }

  static fromJson(character) {}
}
