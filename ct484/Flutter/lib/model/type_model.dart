class TypeModel {
  final int id;
  final String tyname;

  TypeModel({
    required this.id,
    required this.tyname,
  });

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      id: json['id'],
      tyname: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': tyname,
    };
  }
}


class settys {

  List<TypeModel> typet = [];


  void settype(List<dynamic> jsonList) {
    typet = jsonList
        .map((e) => TypeModel.fromJson(e))
        .toList();
  }



}
