class YearModel {
  final int id;
  final String yename;
  final String zone;

  YearModel({
    required this.id,
    required this.yename,
    required this.zone,
  });

  factory YearModel.fromJson(Map<String, dynamic> json) {
    return YearModel(
      id: json['id'],
      yename: json['name'],
      zone: json['zone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': yename,
      'zone': zone,
    };
  }
}

class setyee {

  List<YearModel> years = [];


  void setyear(List<dynamic> jsonList) {
    years = jsonList
        .map((e) => YearModel.fromJson(e))
        .toList();
  }



}