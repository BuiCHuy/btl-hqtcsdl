<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class tienlai extends Model
{
    use HasFactory;
    protected $table = 'v_tienlaitheongay';
    protected $fillable=['ngaylap','lai'];
}
