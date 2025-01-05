<?php

namespace App\Http\Controllers;

use App\Models\tienlai;
use Illuminate\Http\Request;

class tienlai_ctrl extends Controller
{
    public function index(){
        $lai=tienlai::all();
        return view('thongke.tienlai',compact('lai'));
    }
}
