<?php

namespace App\Http\Controllers;

use App\Models\cthd;
use App\Models\hoadon;
use App\Models\MatHang;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class cthd_controller extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(string $id)
    {
        $cthd=cthd::with(['hoadon','mathang'])->find($id);
        return view('cthd.index',compact('cthd'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(string $id)
    {
        $hd=hoadon::find($id);
        $mathang=mathang::all();
        return view('cthd.create',compact('mathang','hd'));
    }

    /**-
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try{
            $mahd=$request->input('mahd');
            $mamh=$request->input('mamh');
            $soluong=$request->input('soluong');
            DB::statement('exec insertcthd @mahd=?,@mamh=?,@sl=?',[$mahd,$mamh,$soluong]);
            return redirect()->route('hoadon.chitiet',$mahd)->with('success','Thêm thành công');
        }
        catch (QueryException $e) {

            if ($e->getCode() == 23000) {

                return redirect()->route('hoadon.chitiet',$mahd)->with('error', 'Lỗi: Không thể thêm chi tiết hóa đơn vì đã tồn tại mã hóa đơn và mã mặt hàng.');
            }
            return redirect()->route('hoadon.chitiet',$mahd)->with('error', 'Lỗi hệ thống: ' . $e->getMessage());

        }


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
    public function edit(string $mahd,string $mamh)
    {
        $cthd=cthd::where('mahd',$mahd)->where('mamh',$mamh)->first();
        $mathang = mathang::all();
        return view('cthd.edit',compact('mathang','cthd'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $mahd,string $mamh)
    {
        try{
            $cthd=cthd::where('mahd',$mahd)->where('mamh',$mamh)->first();
            $mahd=$request->input('mahd');
            $mamh=$request->input('mamh');
            $soluong=$request->input('soluong');
            DB::statement('exec updatecthd @mahd=?,@mamh=?,@sl=?',[$mahd,$mamh,$soluong]);
            return redirect()->route('hoadon.chitiet',$mahd)->with('success','Cập nhật thành công');
        }
        catch (QueryException $e) {

            if ($e->getCode() == 23000) {

                return redirect()->route('hoadon.chitiet',$mahd)->with('error', 'Lỗi: Không thể cập nhật chi tiết hóa đơn vì đã tồn tại mã hóa đơn và mã mặt hàng.');
            }
            return redirect()->route('hoadon.chitiet',$mahd)->with('error', 'Lỗi hệ thống: ' . $e->getMessage());
        }

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $mahd,string $mamh)
    {
        $cthd=cthd::where('mahd',$mahd)->where('mamh',$mamh)->first();
        DB::statement('exec deletecthd @mahd=?,@mamh=?',[$mahd,$mamh]);
        return redirect()->route('hoadon.chitiet',$mahd)->with('success','Xóa nhật thành công');
    }
}
