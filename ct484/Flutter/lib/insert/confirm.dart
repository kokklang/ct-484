import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:po/model/insert_modul.dart';

final show = LocationModel();
final ValueNotifier<bool> isLoading = ValueNotifier(false);


class ConfirmPage extends StatelessWidget {
  const ConfirmPage({super.key});

  Future<void> sendNewItem(BuildContext context) async {
     isLoading.value = true; 
    final uri = Uri.parse("https://pentastyle-unmelodised-elisa.ngrok-free.dev/larapo/public/api/acient-item");
    var request = http.MultipartRequest('POST', uri);

    /// ===== ส่งข้อมูลข้อความ =====
    request.fields['name'] = show.name;
    request.fields['information'] = show.information;
    request.fields['address'] = show.address;
    request.fields['provinces_id'] = show.provinceId.toString();
    request.fields['type_id'] = show.typeId.toString();
    request.fields['year_id'] = show.yearId.toString();

    /// ===== ส่งรูป =====
    if (show.image != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          show.image!,
          filename: 'upload.jpg',
        ),
      );
    }

    try {
      final response = await request.send();
      final body = await response.stream.bytesToString();
      final result = jsonDecode(body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'บันทึกสำเร็จ')),
      );


        await Future.delayed(const Duration(milliseconds: 450));

            if (context.mounted) {
              Navigator.pop(context, true); // true = ส่งค่าสำเร็จกลับไป
            }



    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
      );
    }
    finally {
    isLoading.value = false; // 🔥 หยุดโหลด
  }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ยืนยันการเพิ่ม"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: w.clamp(0, 700),
                child: Card(
                  color: const Color.fromARGB(255, 133, 24, 243),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(13),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildItem("ชื่อ", show.name),
                        _buildItem("รายละเอียด", show.information),
                        _buildItem("ที่อยู่", show.address),
                        _buildItem("จังหวัด", show.provinceName),
                        _buildItem("ภาค", show.rename),
                        _buildItem("ประเภท", show.typeName),
                        _buildItem("ยุค", show.yearName),

                        const SizedBox(height: 12),

                        if (show.image != null)
                          Center(
                            child: Image.memory(
                              show.image!,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              
              SizedBox(
                  width: w > 400 ? 400 : w * 0.7,
                  height: 45,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isLoading,
                    builder: (context, loading, _) {
                      return ElevatedButton(
                        onPressed: loading ? null : () => sendNewItem(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 133, 24, 243),
                          disabledBackgroundColor:
                              const Color.fromARGB(255, 180, 180, 180),
                        ),
                        child: loading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "ยืนยันบันทึกข้อมูล",
                                style: TextStyle(color: Colors.white),
                              ),
                      );
                    },
                  ),
                ),


              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}


 Widget _buildItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color.fromARGB(255, 168, 159, 159) ,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 255, 255, 255)
            ),
          ),
        ],
      ),
    );
  }