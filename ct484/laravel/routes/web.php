<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\controlItem;

use Illuminate\Support\Facades\File;

// Route::get('/', function () {
//     return File::get(public_path('index.html'));
// });

Route::get('/', function () {
    return view('welcome');
});

// Route :: get('/all',function()(
//     $getall = p
 
//         return 
// )
// );

// เช็คเลาท์
// php artisan route:list 
// php artisan cache:clear
//  php artisan route:clear
// ล้างทุกอย่าง
// php artisan optimize:clear 
// php artisan config:clear 

//     Route::get('/items',          [ชื่อคอนโทรล ::class, 'ฟังก์ชั่น']);
// | ส่วนของลิงค์กรอกเเค่นี้เวลาเรียก |    => ที่ต้องใส่เพื่่อเรียก คอลโทรลคลาส เเละฟังชั่น




