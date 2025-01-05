<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class top5seller extends Model
{
    use HasFactory;
    protected $table = 'v_top5banchay';
    protected $fillable = ['mamh','tongsoluong','doanhthu'];
}
