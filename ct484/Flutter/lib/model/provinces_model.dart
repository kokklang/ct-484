class ProvinceModel {

  final int id;
  final String province_name;
  final int region_id;

  ProvinceModel({
    required this.id,
    required this.province_name,
    required this.region_id,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      id: json['id'],
      province_name: json['province_name'],
      region_id: json['region_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'province_name': province_name,
      'region_id': region_id,
    };
  }
}



class setpro {
  List<ProvinceModel> provinces = [];


  void setProvinces(List<dynamic> jsonList) {
    provinces = jsonList
        .map((e) => ProvinceModel.fromJson(e))
        .toList();
  }



}

