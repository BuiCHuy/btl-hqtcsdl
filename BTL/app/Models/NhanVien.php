<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
class NhanVien extends Model
{
    use HasFactory;
    protected $table = 'nhanvien';
    protected $fillable = ['manv', 'hoten', 'diachi', 'ngaysinh', 'gioitinh', 'sdt', 'luong1gio', 'giolam', 'luong'];

}
