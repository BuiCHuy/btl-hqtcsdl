<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MatHang extends Model
{
    use HasFactory;

    protected $fillable = ['mamh', 'tenmh', 'malh', 'dongia', 'soluongtrongkho', 'gianhap'];
    protected $table = 'mathang';

    public function loaihang(){
        return $this->belongsTo(LoaiHang::class, 'malh', 'malh');
    }
}
