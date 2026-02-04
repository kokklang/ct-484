puspec.yml
เเทนที่ใน โฟลเดอร์โปรเจค flutter framework 
เเล้ว เปิด cmd รัน "flutter pub get"
เพื่อโหลดเเพค

===== เปิดเว็บไม่ได้หรือไม่มีข้อมูล ========
เนื่องจาก กำหนด โค้ดไห้รอโหลด api เสร็จก่อน
หรือ url ของ api ในไฟล์ของ flutter ผิด 
ต้องทำการเปลี่ยนชื่อ ที่ชี้ไปยังเครื่อง sever 
--------ตัวอย่าง---------
await http.get(Uri.parse('https://pentastyle-unmelodised-elisa.ngrok-free.dev/larapo/public/api/gettyp'));

                          || เลขเครื่อง sever                                || โฟลเดอร์ ที่เก็บไฟล์ || ชื่อ route
 ถ้ารันด้วย xammp เก็บใน hotdog 
เลข ip = localhost  เลลขเครื่องที่เปิด
/โฟลเดอร์ web / ชื่อ route = /gettyp

url อื่นในเครื่อง main sear insert .dart 3 ไฟล์หลัก


----อีกหนึ่งสาเหตุ หลังจาก หลังจากบิวเเล้ว ต้องเข้าโฟลเดอร์ web ค้นหาไฟล์ index เเก้   <base href="/ตำเเหน่งโฟลเดอร์/web/">



=============โฟลเดอร์หรือไฟล์ต่างๆ==========
-----web---
คือ โฟลเดอร์ เวบที่บิวพร้อมเปปิด เเต่ api ชี้มาที่เครื่อง sever ของ คนเขียน



--------lib-------
คือ ไฟล์ โค้ด เเบง่งเป็น 4
1. main  ไฟล์ เมนู nevigator ด้านล่าง 
2. insert หน้าเพิ่มข้อมูล 
3. sear หน้าค้นหา 
4. โมเดลเก็บข้อมูลต่างๆ เก็บข้อมูลตอนโหลดเเอปปครั้งเเรก จาก api //ข้อมูลตัวเลือก dropdown 



คำสั่งต่างๆ
//ลบไฟล์ บิวที่สร้าง
//สร้าง เว็บ
// เคลีย เเคส เเพคเก็จต่างๆ
//โหลดข้อมูลเเพคเก็จใหม่
// เริ่มเปิด ตัวจำลองต่างๆ
//บิว เเอนดรอย
// Remove-Item -Recurse -Force build/web

// flutter build web
// flutter clean
// flutter pub get
// flutter run
// flutter build apk
// 