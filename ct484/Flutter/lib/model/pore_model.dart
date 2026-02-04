class ProvinceVM {
  final int id;
  final String provinceName;
  final int regionId;
  final String regionName;

  ProvinceVM({
    required this.id,
    required this.provinceName,
    required this.regionId,
    required this.regionName,
  });

  factory ProvinceVM.fromJson(Map<String, dynamic> json) {
    return ProvinceVM(
      id: int.parse(json['id'].toString()),
      provinceName: json['province_name'].toString(),
      regionId: int.parse(json['region_id'].toString()),
      regionName: json['region_name'].toString(),
    );
  }
}

class ProvinceStore {
  List<ProvinceVM> provinces = [];

  void setProvinces(List<dynamic> json) {
    provinces = json.map((e) => ProvinceVM.fromJson(e)).toList();
  }
}

