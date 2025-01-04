<?php

namespace App\Http\Controllers;

use App\Models\hoadon;
use App\Models\KhachHang;
use App\Models\NhanVien;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class hoadon_controller extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $hoadon=hoadon::with(['khachhang','nhanvien'])->get();
        return view('hoadon.index',compact('hoadon'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $khachhang=khachhang::all();
        $nhanvien=nhanvien::all();
        return view('hoadon.create',compact('khachhang','nhanvien'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
