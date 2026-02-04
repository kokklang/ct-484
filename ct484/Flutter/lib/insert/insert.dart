import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import '../model/insert_modul.dart';
import 'confirm.dart';

import '/model/type_model.dart';

import '/model/year_model.dart';
import '/model/pore_model.dart';
 import '../model/textfied_modul.dart';

import 'package:po/main.dart';
/// ==================
/// GLOBAL
/// ==================
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
final store = LocationModel();





/// ==================
/// PAGE
/// ==================
class AddPlacePage extends StatefulWidget {
  const AddPlacePage({super.key});

  @override
  State<AddPlacePage> get createState => _AddPlacePageState();
}
 
class _AddPlacePageState extends State<AddPlacePage> {
  // File? _imageFile;
  


  /// ==================
  /// เลือกรูปจาก Gallery
  /// ==================

 final ValueNotifier<bool> hasImage = ValueNotifier(false);

Future<void> _pickImage() async {
  final picker = ImagePicker();
  final XFile? picked = await picker.pickImage(
    source: ImageSource.gallery,
  );

  if (picked != null) {
    final bytes = await picked.readAsBytes(); 
    store.setImageBytes(bytes);
     hasImage.value = true;
  }
}



  @override
  Widget build(BuildContext context) {
    /// ===== ขนาดหน้าจอ =====
    final screenWidth = MediaQuery.of(context).size.width;
      final screenheight = MediaQuery.of(context).size.height;
    /// ===== กำหนดความกว้างฟอร์ม (responsive + max width) =====
    final double formWidth =
        screenWidth * 0.9 > 480 ? 480 : screenWidth * 0.9;

        final appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
  backgroundColor: const Color.fromARGB(255, 125, 6, 244),
  centerTitle: true,
    toolbarHeight: screenheight*.1,
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.temple_buddhist,size: appBarHeight * .9, color: Colors.white,),
      SizedBox(width: 10,),
      Container(child: Text('โบราณวัตถุวัตถุ',style: TextStyle(fontSize: 20 , color: Colors.white),),
              padding: EdgeInsets.only(bottom: 1), 
              decoration: BoxDecoration(
              border: Border(
              bottom: BorderSide(
              color: Colors.white ,
              width: 2.0,
                  ),
                ),
              ),
             

      ),
    ],
  ),
),


      /// ==================
      /// วิดเจททรี เทมเพลทหน้าจอ ว่าจัดรูปเเบบยังไง ส่วนเเต่งกรอบ สี มีตั้งค่าอยู่ล่าสงสุด
      /// ==================
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: formWidth,
                child: Form(
                  key: formKey,  
                  child: Column(  spacing: 25, 
                    children: [
                      
                  
                        //==== ชื่อ =====
                      ETextField(
                          label: 'ชื่อ',
                          validatorText: 'กรุณากรอชื่อ',
                          onSaved: (v) {
                            store.setName(v!);
                            debugPrint(v);
                            },
                      ),
                      
                      /// ===== รายละเอียด =====
                      
                      ETextField(
                          label: 'ลายละเอียด',
                          validatorText: 'กรุณากรอกข้อมูล',
                          onSaved: (v) {
                            store.setInformation(v!);
                            debugPrint(v);
                            },
                      ),
                      
                      /// ===== ที่อยู่ =====
                      
                      ETextField(
                          label: 'สถานที่ค้นพบ',
                          validatorText: 'กรุณากรอกข้อมูล',
                          onSaved: (v) {
                            store.setAddress(v!);
                            debugPrint(v);
                            },
                      ),
                      
                      /// ===== จังหวัด =====
                      
                          _tbuildDropdown<ProvinceVM>(
                              label: "จังหวัด",
                              items: setpore.provinces,
                              getId: (e) => e.id,
                              getName: (e) => e.provinceName,
                              getRegionName: (e) => e.regionName,
                              onSelected: (id, name, regionName) {
                                store.setProvinceId(id);
                                store.setProvinceName(name);
                                store.setregion(regionName);
                              },
                            ),
                      
                      /// ===== ประเภท =====
                      _buildDropdown<TypeModel>(
                        label: "ประเภท",
                        items: sett.typet,
                        getId: (e) => e.id,
                        getName: (e) => e.tyname,
                        onSelected: (id, name) {
                          store.setTypeId(id);
                          store.setTypeName(name);
                      
                        },
                      ),
                      
                      /// ===== ยุค =====
                      _buildDropdown<YearModel>(
                        label: "ยุค",
                        items: sety.years ,
                        getId: (e) => e.id,
                        getName: (e) => e.yename,
                        onSelected: (id, yname) {
                          store.setYearId(id);
                          store.setYearName(yname);
                        },
                      ),
                      
                      /// ===== ปุ่มเลือกรูป =====
                      
               ValueListenableBuilder<bool>(
                      valueListenable: hasImage,
                      builder: (context, value, _) {
                return   ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: Text(value ? 'เปลี่ยนรูป' : 'เพิ่มรูปภาพ'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      value ? const Color.fromARGB(255, 133, 24, 243) : Colors.white,
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      value ? Colors.white : Colors.grey,
                    ),
                  ),
                );
              },
                        ),
                      
                      
                     
                      
                      /// ===== ปุ่มบันทึก =====
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text("บันทึก"),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                      
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ConfirmPage(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      
                  SizedBox(height: screenheight* .05,),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
      );
    // );
  }


  /// ==================
  /// ตั้งค่า นหา้จอ dropdowwn
  /// ==================
Widget _buildDropdown<T>({
  required String label,
  required List<T> items,
  required int Function(T) getId,
  required String Function(T) getName,
  required void Function(int id, String name) onSelected,
 
}) {
 return LayoutBuilder(
  builder: (context, constraints) {
    return FormField<int>(
      validator: (v) => v == null ? 'กรุณาเลือก$label' : null,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownMenu<int>(
                inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11), // ปรับความกลมที่นี่
    ),
  ),
              width: constraints.maxWidth,
              menuHeight: 250,
              label: Text(label),

              dropdownMenuEntries: items
                  .map(
                    (e) => DropdownMenuEntry<int>(
                      value: getId(e),
                      label: getName(e),
                    ),
                  )
                  .toList(),

              onSelected: (v) {
                field.didChange(v); 
                if (v == null) return;

                final selected =
                    items.firstWhere((e) => getId(e) == v);

                onSelected(
                  getId(selected),
                  getName(selected),
                );
              },
            ),

            if (field.hasError) ...[
              const SizedBox(height: 4),
              Text(
                field.errorText!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        );
      },
    );
  },
);

  
}

Widget _tbuildDropdown<T>({
  required String label,
  required List<T> items,
  required int Function(T) getId,
  required String Function(T) getName,
  required String Function(T) getRegionName, 
  required void Function(
    int id,
    String name,
    String regionName,
  ) onSelected, 
}) {
  return 
 LayoutBuilder(
      builder: (context, constraints) {
        return FormField<int>(
          validator: (v) => v == null ? 'กรุณาเลือก$label' : null,
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownMenu<int>(
                    inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), // ปรับความกลมที่นี่
    ),
  ),
                  width: constraints.maxWidth,
                  menuHeight: 250,
                  label: Text(label),
                  dropdownMenuEntries: items
                      .map(
                        (e) => DropdownMenuEntry<int>(
                          value: getId(e),
                          label:
                              '${getName(e)}    (${getRegionName(e)})',
                        ),
                      )
                      .toList(),
                  onSelected: (v) {
                    field.didChange(v);
                    if (v == null) return;

                    final selected =
                        items.firstWhere((e) => getId(e) == v);

                    onSelected(
                      getId(selected),
                      getName(selected),
                      getRegionName(selected),
                    );
                  },
                ),

                if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      field.errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  
}
}