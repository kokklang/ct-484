import 'dart:math';

import 'package:flutter/material.dart';



class DetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailPage({super.key, required this.data});
  


  String safeText(dynamic v) =>
      (v == null || v.toString().trim().isEmpty) ? '-' : v.toString();

  /// ===== รูป fallback =====
  Widget imageFallback() {
    return Container(
      height: double.maxFinite,
      width: double.infinity,
      color: Colors.grey.shade300,
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 20),
      ),
    );
  }

  /// ===== แสดงรูปจาก URL =====
Widget buildImage(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return imageFallback();
  }

  final uri = Uri.tryParse(imageUrl);
  if (uri == null || !uri.hasAbsolutePath) {
    return imageFallback();
  }

  return ConstrainedBox(
    constraints: const BoxConstraints(maxHeight: 500, minWidth: 500),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(11), 
      child: Image.network(
        imageUrl,
        fit: BoxFit.scaleDown ,// ให้รูปขยายเต็มพื้นที่ที่กำหนดโดยไม่เสียสัดส่วน
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: 100, // กำหนดความสูงระหว่างรอโหลดเพื่อไม่ให้ Layout กระตุก
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => imageFallback(),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final String? imageUrl = data['image'];

    return Scaffold(
      appBar: AppBar(
            title: Text(safeText(data['name'])),
            centerTitle: true,
            backgroundColor:  Color.fromARGB(255, 125, 6, 244), // ตั้งค่าสีพื้นหลัง AppBar [1]
            foregroundColor: Colors.white, // ตั้งค่าสีข้อความและไอคอน [1]
            elevation: 2, 
            toolbarHeight: 70,// ใส่เงาให้ AppBar [1]
          ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== รูป =====
            buildImage(imageUrl),

            /// ===== รายละเอียด =====
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    safeText(data['name']),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  info('รายละเอียด ', data['information']),
                  info('ที่อยู่ ', data['address']),
                  info('จังหวัด ', data['province_name']),
                  info("ภาค ", data ['region_name']),
                  info('ประเภท ', data['type_name']),
                  info('ปี ', data['year_name']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget info(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$label : ${safeText(value)}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
