<?php

namespace App\Http\Controllers;

use App\Models\hoadon;
use App\Models\top5seller;
use Illuminate\Http\Request;

class top5seller_ctrl extends Controller
{
    public function index()
    {
        $top5seller = top5seller::all();
        return view('thongke.top5seller',compact('top5seller'));
    }
}
