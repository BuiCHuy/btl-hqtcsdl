<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class cthd extends Model
{
    use HasFactory;
    protected $table='chitiethoadon';
    protected $fillable = ['mahd','mamh','soluong','thanhtien'];
    function hoadon(){
        return $this->belongsTo(hoadon::class);
    }
    function mathang(){
        return $this->belongTo(MatHang::class);
    }
}
