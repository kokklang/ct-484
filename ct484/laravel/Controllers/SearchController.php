<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SearchController extends Controller
{
    public function newsearch(Request $request)
    {
        $query = DB::table('item')
            ->join('provinces', 'item.provinces_id', '=', 'provinces.id')
            ->join('regions', 'provinces.region_id', '=', 'regions.id')
            ->join('type', 'item.type_id', '=', 'type.id')
            ->join('year', 'item.year_id', '=', 'year.id')
            ->select(
                'item.id',
                'item.name',
                'item.information',
                'item.address',
                'item.image',

                'provinces.province_name as province_name',
                'regions.name as region_name',
                'type.name as type_name',
                'year.name as year_name',
                'year.zone as zone_name'
            );

        // ===== filter ภาค =====
        if ($request->filled('region_id')) {
            $query->where('regions.id', $request->region_id);
        }

        // ===== filter จังหวัด =====
        if ($request->filled('provinces_id')) {
            $query->where('item.provinces_id', $request->provinces_id);
        }

        // ===== filter ประเภท =====
        if ($request->filled('type_id')) {
            $query->where('item.type_id', $request->type_id);
        }

        // ===== filter ยุค =====
        if ($request->filled('year_id')) {
            $query->where('item.year_id', $request->year_id);
        }

        $results = $query->get();

        // ===== จัดการ path รูป =====
        $results = $results->map(function ($item) {
            $item->image = $item->image
                ? rtrim(config('app.url'), '/') . '/storage/item/' . basename($item->image)
                : null;
            return $item;
        });

        return response()->json([
            'count' => $results->count(),
            'data'  => $results
        ]);
    }
}
