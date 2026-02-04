import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/model/type_model.dart';

import '/model/year_model.dart';

import 'detaill.dart';
import 'package:po/main.dart'; 

import '/model/pore_model.dart';// setpo, sett, sety

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> get createState => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int? provinceId;
  int? typeId;
  int? yearId;
  int? regiId;


  bool isLoading = false;
  String? error;

  /// เก็บผลลัพธ์
  List<dynamic> items = [];

  /// =======================
  /// CALL API
  /// =======================
  Future<void> search() async {
  if (isLoading) return;

  setState(() {
    isLoading = true;
    error = null;
  });

  try {
    final res = await http.post(
      Uri.parse(
        "https://pentastyle-unmelodised-elisa.ngrok-free.dev/larapo/public/api/newsearch",
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "provinces_id": provinceId,
        "type_id": typeId,
        "year_id": yearId,
        "region_id" :regiId,

      }),
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);

      setState(() {
        items = json['data'] ?? [];
        isLoading = false;
        regiId = null;
        provinceId = null;
        typeId = null;
        yearId = null;
      });
    } else {
      throw Exception("โหลดข้อมูลไม่สำเร็จ");
    }
  } catch (e) {
    setState(() {
      error = e.toString();
      isLoading = false;
    });
  }
}


  /// =======================
  /// UI
  /// =======================
   @override
Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
  title: const Text("ค้นหาข้อมูล"),
  centerTitle: true,
  elevation: 5,
  backgroundColor:  Color.fromARGB(255, 125, 6, 244),
  titleTextStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
),

    
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// ===== ROW DROPDOWN (SCROLL ซ้าย–ขวา) =====
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                  child: _buildDropMenu<ProvinceVM>(
                    label: "ภาค",
                    items: setpore.provinces,
                    getId: (e) => e.regionId,
                    getName: (e) => e.regionName,
                    onChanged: (id){ regiId = id;
                     debugPrint('regionId=$regiId');}

                  ),
                ),
                const SizedBox(width: 8),

                SizedBox(
                  width: 180,
                  child: _buildDropMenu<ProvinceVM>(
                    label: "จังหวัด",
                    items: setpore.provinces,
                    getId: (e) => e.id,
                    getName: (e) => e.provinceName,
                    onChanged: (id)  {provinceId = id;
                     debugPrint('regionId=$provinceId');}

                  ),
                ),
                const SizedBox(width: 8),

                SizedBox(
                  width: 160,
                  child: _buildDropMenu<TypeModel>(
                    label: "ประเภท",
                    items: sett.typet,
                    getId: (e) => e.id,
                    getName: (e) => e.tyname,
                    onChanged: (id) { typeId = id; debugPrint('regionId=$typeId');}
                  ),
                ),
                const SizedBox(width: 8),

                SizedBox(
                  width: 140,
                  child: _buildDropMenu<YearModel>(
                    label: "ยุคสมัย",
                    items: sety.years,
                    getId: (e) => e.id,
                    getName: (e) => e.yename,
                    onChanged: (id) { yearId = id;  debugPrint('regionId=$yearId');}
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ===== BUTTON =====

Container(
  constraints: BoxConstraints(maxWidth: 700), // กำหนดค่าสูงสุด
  width: MediaQuery.of(context).size.width,
  height: 45,
  child: SizedBox(
    width: double.infinity,
    height: 45,
            child: ElevatedButton(
              onPressed: isLoading ? null : search,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("ค้นหา"),
            ),)
          ),
           const SizedBox(height: 16),

          /// ✅ ตรงนี้แหละที่หายไป
          Expanded(
            child: buildResult(),)
        ],
      ),
    ),
  );
}

  /// =======================
  /// RESULT LIST
  /// =======================
Widget buildResult() {
  if (isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (error != null) {
    return Center(child: Text(error!));
  }

  if (items.isEmpty) {
    return const Center(child: Text("ไม่มีข้อมูล"));
  }

  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: ListTile(
          leading: (item['image'] != null &&
                  item['image'].toString().isNotEmpty)
              ? CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: Image.network(
                      item['image'],
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const SizedBox(
                          width: 16,
                          height: 16,
                          child:
                              CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                      errorBuilder: (_, __, ___) =>
                          const SizedBox(),
                    ),
                  ),
                )
              : null,

          title: Text(item['name'] ?? '-'),
          subtitle: Text(item['address'] ?? '-'),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(data: item),
              ),
            );
          },
        ),
      );
    },
  );
}


  /// =======================
  /// DROPDOWN BUILDER
  /// =======================

Widget _buildDropMenu<T>({
  required String label,
  required List<T> items,
  required int Function(T) getId,
  required String Function(T) getName,
  required void Function(int id) onChanged,
}) {
  final controller = TextEditingController();

  return DropdownMenu<int>(
      inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), // ปรับความกลมที่นี่
    ),
  ),
    controller: controller,
    label: Text(label),

    // 🔍 พิมพ์ค้นหาได้
    enableSearch: true,
    enableFilter: true,
    requestFocusOnTap: true,

    width: double.infinity,
    menuHeight: 300,

    dropdownMenuEntries: items
        .map(
          (e) => DropdownMenuEntry<int>(
            value: getId(e),
            label: getName(e),
          ),
        )
        .toList(),

    onSelected: (v) {
      if (v == null) return;
      onChanged(v);
    },
  );
}
}