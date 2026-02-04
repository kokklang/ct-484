<?php

use App\Http\Controllers\alllstart;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\add;
use App\Http\Controllers\SearchController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


Route::get('/users', function () {return 'route ok';});
Route::get('/index', [alllstart::class, 'index']);



Route::post('/acient-item', [add::class, 'store']);




// ==== ดึงค่าทำดรอบดาว ===
Route::get('/gettype', [alllstart::class, 'gett']);
Route::get('/getyear', [alllstart::class, 'gety']);
Route::get('/gettyp', [alllstart::class, 'gggg']);
Route::get('/getp', [alllstart::class, 'getp']);


Route::post('/newsearch', [SearchController::class, 'newsearch']);

Route::get('/check', function () {
    return 'ok';
});

// php artisan serve --host=0.0.0.0 --port=8000
// ngrok start --all
// php artisan serve --port=80