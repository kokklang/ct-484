import 'dart:typed_data';

class LocationModel {
  static final LocationModel _instance = LocationModel._internal();
  factory LocationModel() => _instance;
  LocationModel._internal();

  // ===== text =====
  String name = "";
  String information = "";
  String address = "";

  // ===== id =====
  int provinceId = 0;
  int typeId = 0;
  int yearId = 0;

  // ===== display name =====
  String provinceName = "";
  String typeName = "";
  String yearName = "";
  String rename = "";
  // ===== image =====
  Uint8List? image;

  // ===== setters =====
  void setName(String v) => name = v;
  void setInformation(String v) => information = v;
  void setAddress(String v) => address = v;

  void setProvinceId(int v) => provinceId = v;
  void setTypeId(int v) => typeId = v;
  void setYearId(int v) => yearId = v;

  void setProvinceName(String v) => provinceName = v;
  void setTypeName(String v) => typeName = v;
  void setYearName(String v) => yearName = v;
  void setregion(String v) => rename = v;

  void setImageBytes(Uint8List bytes) => image = bytes;

  // ===== to API =====
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "information": information,
      "address": address,
      "provinces_id": provinceId,
      "type_id": typeId,
      "year_id": yearId,
    };
  }
}





// 