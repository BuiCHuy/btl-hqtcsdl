<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class hoadon extends Model
{
    use HasFactory;
    protected $table = 'hoadon';
    protected $primaryKey = 'mahd';
    protected $keyType = 'string';
    public $incrementing = false;
    protected $fillable = ['mahd','makh','manv','ngaylap','tongtien'];
    public $timestamps = false;
    function khachhang(){
        return $this->belongsTo(KhachHang::class,'makh','makh');
    }
    function nhanvien(){
        return $this->belongsTo(NhanVien::class,'manv','manv');
    }
}
