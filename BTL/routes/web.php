<?php

use App\Http\Controllers\hoadon_controller;
use Illuminate\Support\Facades\Route;

Route::get('/', hoadon_controller::class.'@index')->name('hoadon.index');
Route::get('/hoadon/create', hoadon_controller::class.'@create')->name('hoadon.create');
