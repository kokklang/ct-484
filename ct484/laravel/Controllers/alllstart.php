<?php
// คอนโทรน รับบค่ามาจาก request  เเล้วส่งไปไห้ model
// เปิดตำเเหน่งให้ route หาเจอได้
namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;

use App\Models\Item;

// ใช้รับค่าจาก form / api
use Illuminate\Http\Request;

// use App\Http\Controllers\Controller;
// ชื่อไฟล์ กับคลาส ต้องตรงกัน

class alllstart extends Controller{

        // dd($request->all());
    
    //     public function index()
    // {   
    //     $users = DB::table('item')->get();
    //     return response()->json($users);
    // }

    public function index()
{
    $items = Item::all()->map(function ($item) {
        return [
            'id' => $item->id,
            'name' => $item->name,
            'information' => $item->information,
            'address' => $item->address,
            'provinces_id' => $item->provinces_id,
            'type_id' => $item->type_id,
            'year_id' => $item->year_id,

           
           'image' => $item->image,
                    ];
                });

                return response()->json($items);
            }


    public function gett()
    {
        $Types = DB::table('type')->get();
        return response()->json($Types);
    }

    
    public function gety()
    {
        $year = DB::table( 'year')->get();
        return response()->json($year);
    }


    public function getp()
    {
        $provences = DB::table('provinces')->get();
        return response()->json($provences);
    }

    
    public function gggg()
    {
        $data = DB::table('provinces')
            ->join('regions', 'regions.id', '=', 'provinces.region_id')
            ->select(
                'provinces.id',
                'provinces.province_name',
                'provinces.region_id',
                'regions.name as region_name'
            )
            ->orderBy('provinces.province_name')
            ->get();

        return response()->json($data);
    }



   
}




