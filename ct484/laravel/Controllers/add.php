<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Item;

class add extends Controller
{
    public function store(Request $request)
    {
        // 
        $request->validate([
            'name' => 'required|string|max:100',
            'information' => 'nullable|string',
            'address' => 'nullable|string|max:250',
            'provinces_id' => 'required|integer',
            'type_id' => 'required|integer',
            'year_id' => 'required|integer',
            'image' => 'required|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        // 
        $path = $request->file('image')
                        ->store('item', 'public');

        // 
        $item = Item::create([
            'name' => $request->name,
            'information' => $request->information,
            'address' => $request->address,
            'provinces_id' => $request->provinces_id,
            'type_id' => $request->type_id,
            'year_id' => $request->year_id,
            'image' => $path,
        ]);

        // 
        return response()->json([
            'status' => true,
            'id' => $item->id,
            'image' => $item->image, 
        ]);

    }
}
