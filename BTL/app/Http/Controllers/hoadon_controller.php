<?php

namespace App\Http\Controllers;

use App\Models\cthd;
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
        $hoadon=hoadon::with(['khachhang','nhanvien'])->paginate(5);
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
        $mahd = $request->input('mahd');
        $makh = $request->input('makh');
        $manv = $request->input('manv');
        $ngaylap = $request->input('ngaylap');
        DB::statement('exec inserthoadon @mahd=?,@makh=?,@manv=?,@ngaylap=?',[$mahd,$makh,$manv,$ngaylap]);
        return redirect()->route('hoadon.index')->with('success','Thêm thành công');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $hd = hoadon::find($id);
        return redirect()->route('cthd.index');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $hd = hoadon::find($id);
        $khachhang=khachhang::all();
        $nhanvien=nhanvien::all();

        return view('hoadon.edit',compact('hd','khachhang','nhanvien'));

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $hd = hoadon::find($id);
        $mahd = $request->input('mahd');
        $makh = $request->input('makh');
        $manv = $request->input('manv');
        $ngaylap = $request->input('ngaylap');
        DB::statement('exec updatehoadon @mahd=?,@makh=?,@manv=?,@ngaylap=?',[$mahd,$makh,$manv,$ngaylap]);
        return redirect()->route('hoadon.index')->with('success','Cập nhật thành công');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $hd = hoadon::find($id);
        DB::statement('exec deletehoadon @mahd=?',[$id]);
        return redirect()->route('hoadon.index')->with('success','Xóa thành công');
    }
    public function chitiet(string $mahd){
        $hd = hoadon::find($mahd);
        $cthd = cthd::where('mahd',$mahd)->get();
        return view('hoadon.chitiet',compact('cthd','hd'));
    }
    public function quyDoiDiem($mahd)
    {
        DB::statement('EXEC proc_QuyDoiDiem ?', [$mahd]);
        return redirect()->route('hoadon.index')->with('success', 'Quy đổi điểm thành công!');
    }
}
