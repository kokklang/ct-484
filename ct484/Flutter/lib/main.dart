import 'package:flutter/material.dart';

import 'insert/insert.dart';
import 'Search/search.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/provinces_model.dart'; 
import 'model/type_model.dart'; 
import 'model/year_model.dart'; 
import './model/pore_model.dart';
import 'dart:async'; 




final  setpo = setpro();
final  sety = setyee();
final  sett = settys();
final setpore = ProvinceStore();

Timer? _timer; 

void main() {
  runApp(const MyApp());
}

// ================== APP ==================
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomBar(),
    );
  }
}

// ================== BOTTOM BAR ==================
class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar>  get createState => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  bool loading = true;

  final pages = const [AddPlacePage(),SearchPage(), ];

  @override
  void initState() {
    super.initState();
    loadAllData(); //  เรียก API ตอนเปิดแอป
      _timer = Timer.periodic(Duration(seconds: 60), (timer) {
    loadAllData();
  });


  }
  @override
void dispose() {
  _timer?.cancel(); // 4. ยกเลิก timer เมื่อปิดหน้าจอนี้
  super.dispose();
}

  // ================== LOAD API ==================
  Future<void> loadAllData() async {
    try { 
      final respore =
          await http.get(Uri.parse('https://pentastyle-unmelodised-elisa.ngrok-free.dev/larapo/public/api/gettyp'));

      final resProvince =
          await http.get(Uri.parse('https://pentastyle-unmelodised-elisa.ngrok-free.dev/larapo/public/api/getp'));

      final resType =
          await http.get(Uri.parse('https://pentastyle-unmelodised-elisa.ngrok-free.dev/larapo/public/api/gettype'));

      final resYear =
          await http.get(Uri.parse('https://pentastyle-unmelodised-elisa.ngrok-free.dev/larapo/public/api/getyear'));

  

        
      if (respore.statusCode == 200) {
        setpore.setProvinces(jsonDecode(respore.body));

        setState(() {});
      }
      if (resType.statusCode == 200) {
        sett.settype(jsonDecode(resType.body));
      }

      if (resYear.statusCode == 200) {
        sety.setyear(jsonDecode(resYear.body));
      }

      if (resProvince.statusCode == 200) {
              setpo.setProvinces(jsonDecode(resProvince.body));
            }
      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint('API ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        height: navBarHeight(context),
        items: const [
          Icon(Icons.add, size: 40, color: Colors.white),
          Icon(Icons.find_in_page_sharp, size: 40, color: Colors.white),
        ],
        color: const Color.fromARGB(255, 125, 6, 244),
        buttonBackgroundColor: const Color.fromARGB(255, 125, 6, 244),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 350),
        onTap: (index) => setState(() => _page = index),
      ),
    );
  }
}

// ================== NAV HEIGHT ==================
double navBarHeight(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

  double height;

  if (kIsWeb ||
      Platform.isWindows ||
      Platform.isMacOS ||
      Platform.isLinux) {
    height = screenHeight * 0.12;
  } else {
    height = screenHeight * 0.09;
  }

  return height.clamp(50.0, 75.0);
}
  

// Remove-Item -Recurse -Force build/web

// flutter build web
// flutter clean
// flutter pub get
// flutter run
// flutter build apk
// flutter build appbundle
// 
